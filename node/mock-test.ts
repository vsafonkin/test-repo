import cp = require('child_process');
import fs = require('fs');
import ncp = require('child_process');
import os = require('os');
import path = require('path');
import cmdm = require('./taskcommand');
import shelljs = require('shelljs');
import syncRequest from 'sync-request';

const COMMAND_TAG = '[command]';
const COMMAND_LENGTH = COMMAND_TAG.length;
const downloadDirectory = path.join(process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE as string, 'azure-pipelines-task-lib', '_download');

export class MockTestRunner {
    constructor(testPath: string, taskJsonPath?: string) {
        this._taskJsonPath = taskJsonPath || '';
        this._testPath = testPath;
        this.nodePath = this.getNodePath();
    }

    private _testPath = '';
    private _taskJsonPath = '';
    public nodePath = '';
    public stdout = '';
    public stderr = '';
    public cmdlines = {};
    public invokedToolCount = 0;
    public succeeded = false;
    public errorIssues: string[] = [];
    public warningIssues: string[] = [];

    get failed(): boolean {
        return !this.succeeded;
    }

    public ran(cmdline: string): boolean {
        return this.cmdlines.hasOwnProperty(cmdline.trim());
    }

    public createdErrorIssue(message: string): boolean {
        return this.errorIssues.indexOf(message.trim()) >= 0;
    }

    public createdWarningIssue(message: string): boolean {
        return this.warningIssues.indexOf(message.trim()) >= 0;
    }

    public stdOutContained(message: string): boolean {
        return this.stdout.indexOf(message) > 0;
    }

    public stdErrContained(message: string): boolean {
        return this.stderr.indexOf(message) > 0;
    }

    public run(nodeVersion?: number): void {
        this.cmdlines = {};
        this.invokedToolCount = 0;
        this.succeeded = true;

        this.errorIssues = [];
        this.warningIssues = [];

        let nodePath = this.nodePath;
        if (nodeVersion) {
            nodePath = this.getNodePath(nodeVersion);
        }
        let spawn = cp.spawnSync(nodePath, [this._testPath]);

        // Clean environment
        Object.keys(process.env)
            .filter(key => (key.substr(0, 'INPUT_'.length) === 'INPUT_' ||
                            key.substr(0, 'SECRET_'.length) === 'SECRET_' ||
                            key.substr(0, 'VSTS_TASKVARIABLE_'.length) === 'VSTS_TASKVARIABLE_'))
            .forEach(key => delete process.env[key]);

        if (spawn.error) {
            console.error('Running test failed');
            console.error(spawn.error.message);
            return;
        }

        this.stdout = spawn.stdout.toString();
        this.stderr = spawn.stderr.toString();

        if (process.env['TASK_TEST_TRACE']) {
            console.log('');
        }

        let lines: string[] = this.stdout.replace(/\r\n/g, '\n').split('\n');
        let traceFile: string = this._testPath + '.log';
        lines.forEach((line: string) => {
            let ci = line.indexOf('##vso[');
            let cmd: cmdm.TaskCommand | undefined;
            let cmi = line.indexOf(COMMAND_TAG);
            if (ci >= 0) {
                cmd = cmdm.commandFromString(line.substring(ci));
                if (cmd.command === 'task.complete' && cmd.properties['result'] === 'Failed') {
                    this.succeeded = false;
                }

                if (cmd.command === 'task.issue' && cmd.properties['type'] === 'error') {
                    this.errorIssues.push(cmd.message.trim());
                }

                if (cmd.command === 'task.issue' && cmd.properties['type'] === 'warning') {
                    this.warningIssues.push(cmd.message.trim());
                }
            }
            else if (cmi == 0 && line.length > COMMAND_LENGTH) {
                let cmdline: string = line.substr(COMMAND_LENGTH).trim();
                this.cmdlines[cmdline] = true;
                this.invokedToolCount++;
            }

            if (process.env['TASK_TEST_TRACE']) {
                fs.appendFileSync(traceFile, line + os.EOL);

                if (line && !cmd) {
                    console.log(line);
                }
                // don't print task.debug commands to console - too noisy.
                // otherwise omit command details - can interfere during CI.
                else if (cmd && cmd.command != 'task.debug') {
                    console.log(`${cmd.command} details omitted`);
                }
            }
        });

        if (this.stderr && process.env['TASK_TEST_TRACE']) {
            console.log('STDERR: ' + this.stderr);
            fs.appendFileSync(traceFile, 'STDERR: ' + this.stderr + os.EOL)
        }

        if (process.env['TASK_TEST_TRACE']) {
            console.log('TRACE FILE: ' + traceFile);
        }
    }

    // Returns a path to node.exe with the correct version for this task (based on if its node10 or node)
    private getNodePath(nodeVersion?: number): string {
        const version: number = nodeVersion || this.getNodeVersion();

        let downloadVersion: string;
        switch (version) {
            case 5:
                downloadVersion = 'v5.10.1';
                break;
            case 6:
                downloadVersion = 'v6.17.1';
                break;
            case 10:
                downloadVersion = 'v10.21.0';
                break;
            case 14:
                downloadVersion = 'v14.11.0';
                break;
            default:
                throw new Error('Invalid node version, must be 5, 6, 10, or 14 (received ' + version + ')');
        }

        // Install node in home directory if it isn't already there.
        const downloadDestination: string = path.join(downloadDirectory, 'node' + version);
        const pathToExe: string = this.getPathToNodeExe(downloadVersion, downloadDestination);
        if (pathToExe) {
            return pathToExe;
        }
        else {
            return this.downloadNode(downloadVersion, downloadDestination);
        }
    }

    // Determines the correct version of node to use based on the contents of the task's task.json. Defaults to Node 14.
    private getNodeVersion(): number {
        const taskJsonPath: string = this.getTaskJsonPath();
        if (!taskJsonPath) {
            console.warn('Unable to find task.json, defaulting to use Node 14');
            return 10;
        }
        const taskJsonContents = fs.readFileSync(taskJsonPath, { encoding: 'utf-8' });
        const taskJson: object = JSON.parse(taskJsonContents);

        let nodeVersionFound = false;
        const execution: object = (
            taskJson['execution']
            || taskJson['prejobexecution']
            || taskJson['postjobexecution']
        );
        const keys = Object.keys(execution);
        for (let i = 0; i < keys.length; i++) {
            if (keys[i].toLowerCase() == 'node14') {
                // Prefer node 14 and return immediately.
                return 14;
            } else if (keys[i].toLowerCase() == 'node10') {
                // Prefer node 10 and return immediately.
                return 10;
            } else if (keys[i].toLowerCase() == 'node') {
                nodeVersionFound = true;
            }
        }

        if (!nodeVersionFound) {
            console.warn('Unable to determine execution type from task.json, defaulting to use Node 10');
            return 10;
        }

        return 6;
    }

    // Returns the path to the task.json for the task being tested. Returns null if unable to find it.
    // Searches by moving up the directory structure from the initial starting point and checking at each level.
    private getTaskJsonPath(): string {
        if (this._taskJsonPath) {
            return this._taskJsonPath;
        }
        let curPath: string = this._testPath;
        let newPath: string = path.join(this._testPath, '..');
        while (curPath != newPath) {
            curPath = newPath;
            let taskJsonPath: string = path.join(curPath, 'task.json');
            if (fs.existsSync(taskJsonPath)) {
                return taskJsonPath;
            }
            newPath = path.join(curPath, '..');
        }
        return '';
    }

    // Downloads the specified node version to the download destination. Returns a path to node.exe
    private downloadNode(nodeVersion: string, downloadDestination: string): string {
        shelljs.rm('-rf', downloadDestination);
        let nodeUrl: string = process.env['TASK_NODE_URL'] || 'https://nodejs.org/dist';
        nodeUrl = nodeUrl.replace(/\/$/, '');  // ensure there is no trailing slash on the base URL
        let downloadPath = '';
        switch (this.getPlatform()) {
            case 'darwin':
                this.downloadTarGz(nodeUrl + '/' + nodeVersion + '/node-' + nodeVersion + '-darwin-x64.tar.gz', downloadDestination);
                downloadPath = path.join(downloadDestination, 'node-' + nodeVersion + '-darwin-x64', 'bin', 'node');
                break;
            case 'linux':
                this.downloadTarGz(nodeUrl + '/' + nodeVersion + '/node-' + nodeVersion + '-linux-x64.tar.gz', downloadDestination);
                downloadPath = path.join(downloadDestination, 'node-' + nodeVersion + '-linux-x64', 'bin', 'node');
                break;
            case 'win32':
                this.downloadFile(nodeUrl + '/' + nodeVersion + '/win-x64/node.exe', downloadDestination, 'node.exe');
                this.downloadFile(nodeUrl + '/' + nodeVersion + '/win-x64/node.lib', downloadDestination, 'node.lib');
                downloadPath = path.join(downloadDestination, 'node.exe')
        }

        // Write marker to indicate download completed.
        const marker = downloadDestination + '.completed';
        fs.writeFileSync(marker, '');

        return downloadPath;
    }

    // Downloads file to the downloadDestination, making any necessary folders along the way.
    private downloadFile(url: string, downloadDestination: string, fileName: string): void {
        const filePath: string = path.join(downloadDestination, fileName);
        if (!url) {
            throw new Error('Parameter "url" must be set.');
        }
        if (!downloadDestination) {
            throw new Error('Parameter "downloadDestination" must be set.');
        }
        console.log('Downloading file:', url);
        shelljs.mkdir('-p', downloadDestination);
        const result: any = syncRequest('GET', url);
        fs.writeFileSync(filePath, result.getBody());
    }

    // Downloads tarGz to the download destination, making any necessary folders along the way.
    private downloadTarGz(url: string, downloadDestination: string): void {
        if (!url) {
            throw new Error('Parameter "url" must be set.');
        }
        if (!downloadDestination) {
            throw new Error('Parameter "downloadDestination" must be set.');
        }
        const tarGzName: string = 'node.tar.gz';
        this.downloadFile(url, downloadDestination, tarGzName);

        // Extract file
        const originalCwd: string = process.cwd();
        process.chdir(downloadDestination);
        try {
            ncp.execSync(`tar -xzf "${path.join(downloadDestination, tarGzName)}"`);
        }
        catch {
            throw new Error('Failed to unzip node tar.gz from ' + url);
        }
        finally {
            process.chdir(originalCwd);
        }
    }

    // Checks if node is installed at downloadDestination. If it is, returns a path to node.exe, otherwise returns null.
    private getPathToNodeExe(nodeVersion: string, downloadDestination: string): string {
        let exePath = '';
        switch (this.getPlatform()) {
            case 'darwin':
                exePath = path.join(downloadDestination, 'node-' + nodeVersion + '-darwin-x64', 'bin', 'node');
                break;
            case 'linux':
                exePath = path.join(downloadDestination, 'node-' + nodeVersion + '-linux-x64', 'bin', 'node');
                break;
            case 'win32':
                exePath = path.join(downloadDestination, 'node.exe');
        }

        // Only use path if marker is found indicating download completed successfully (and not partially)
        const marker = downloadDestination + '.completed';

        if (fs.existsSync(exePath) && fs.existsSync(marker)) {
            return exePath;
        }
        else {
            return '';
        }
    }

    private getPlatform(): string {
        let platform: string = os.platform();
        if (platform != 'darwin' && platform != 'linux' && platform != 'win32') {
            throw new Error('Unexpected platform: ' + platform);
        }
        return platform;
    }
}
