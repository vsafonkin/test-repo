import * as path from 'path';

console.log('hello');


const myPath = "C:/python-version"

if(path.isAbsolute(myPath)) {
    console.log("Absolute", myPath)    
}