class StdIn {
    class func nextLine() -> String {
        return readLine()!
    }

    class func nextLine() -> [Int] {
        let line: String = nextLine()
        let parts: [Substring] = line.split(separator: " ")
        return parts.map { Int($0)! }
    }
}


extension Array where Element : Numeric {
    func sum() -> Element {
        return self.reduce(0, { $0 + $1 })
    }
}


let countLine: String = StdIn.nextLine()
let array: [Int] = StdIn.nextLine()
let result: Int = array.sum()
print(result)
