"use strict";
var _a;
exports.__esModule = true;
var fs = require("fs");
var content = fs.readFileSync("./package.json", 'utf8');
// const found = content.match(/^(?:nodejs\s+)?v?(?<version>[^\s]+)$/m);
// const groups = found?.groups
// console.log(groups)
// const nodeVersion = found?.groups?.version;
var nodeVersion = (_a = JSON.parse(content).engines) === null || _a === void 0 ? void 0 : _a.node;
console.log(nodeVersion);
