"use strict";
exports.__esModule = true;
var semver = require("semver");
console.log('hello');
var latestVersion = '1.2.3-rc1';
var inputVersion = '3.x';
console.log(semver.valid(inputVersion));
var result = semver.satisfies(latestVersion, inputVersion, { includePrerelease: true });
console.log(result);
