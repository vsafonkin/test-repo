function Test() {
    try {
        console.log('hello')
        return 1
    } finally {
        console.log('finally block')
    }
    return -1
}

console.log(Test())