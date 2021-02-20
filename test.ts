import * as semver from 'semver';

console.log('hello');

const latestVersion = '1.2.3-rc1';
const inputVersion = '3.x';


console.log(semver.valid(inputVersion));
const result = semver.satisfies(latestVersion, inputVersion, { includePrerelease: true});
console.log(result);