import * as semver from 'semver';
import * as fs from 'fs';
import { version } from 'os';

const content = fs.readFileSync("./package.json", 'utf8')

// const found = content.match(/^(?:nodejs\s+)?v?(?<version>[^\s]+)$/m);
// const groups = found?.groups
// console.log(groups)
// const nodeVersion = found?.groups?.version;
const nodeVersion = JSON.parse(content).engines?.node;
console.log(nodeVersion)