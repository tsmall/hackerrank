struct BillInfo {
    let skippedItemIndex: Int
    let itemCosts: [Int]
    let chargedAmount: Int
}

extension Array where Element : Numeric {
    func sum() -> Element {
        return self.reduce(0, { $0 + $1 })
    }
}

class StdIn {
    private init() {}

    static let instance = StdIn()

    func nextLine() -> String {
        return readLine()!
    }

    func nextLine() -> [Int] {
        let line: String = nextLine()
        let parts: [Substring] = line.split(separator: " ")
        return parts.map { Int($0)! }
    }
}

class InputParser {
    private var _bill: BillInfo?
    let stdin: StdIn

    init(stdin: StdIn) {
        self._bill = nil
        self.stdin = stdin
    }

    var bill: BillInfo {
        get {
            if let bill = _bill {
                return bill
            }

            let line1: [Int] = stdin.nextLine()
            let line2: [Int] = stdin.nextLine()
            let line3: [Int] = stdin.nextLine()

            _bill = BillInfo(
              skippedItemIndex: line1[1],
              itemCosts: line2,
              chargedAmount: line3[0]
            )

            return _bill!
        }
    }
}

class Diner {
    func whatIsOwed(forBill bill: BillInfo) -> Int {
        return bill.chargedAmount - expectedAmount(forBill: bill)
    }

    func expectedAmount(forBill bill: BillInfo) -> Int {
        var eatenItemCosts = bill.itemCosts
        eatenItemCosts.remove(at: bill.skippedItemIndex)
        return eatenItemCosts.sum() / 2
    }
}

func reportResults(_ difference: Int) -> String {
    return difference == 0 ? "Bon Appetit" : String(difference)
}

let parser = InputParser(stdin: StdIn.instance)
let anna = Diner()
let difference = anna.whatIsOwed(forBill: parser.bill)

print(reportResults(difference))
