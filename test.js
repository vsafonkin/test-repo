"use strict";
exports.__esModule = true;
var path = require("path");
console.log('hello');
var myPath = "C:/python-version";
if (path.isAbsolute(myPath)) {
    console.log("Absolute", myPath);
}
