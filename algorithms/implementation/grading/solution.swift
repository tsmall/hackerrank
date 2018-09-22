// ---------------------------------------------------------------------------
// Solution

class Solution {
    private let parser: GradeParser
    private let writer: GradeWriter

    init(input: LineParser, output: Writer) {
        self.parser = GradeParser(input: input)
        self.writer = GradeWriter(output: output)
    }

    lazy var grades: [Grade] = parser.parseGrades()

    func run() {
        writer.writeGrades(grades)
    }
}

struct Grade {
    let failingScore = 40
    private let _score: Int

    init(score: Int) {
        _score = score
    }

    var score: Int {
        return roundedScore
    }

    private var roundedScore: Int {
        let possible = _score.next(divisibleBy: 5)
        if possible - _score < 3 && possible >= failingScore {
            return possible
        }
        return _score
    }
}

extension Grade: CustomStringConvertible {
    var description: String {
        return "\(score)"
    }
}

extension Int {
    func next(divisibleBy divisor: Int) -> Int {
        var result = self
        while result % divisor != 0 {
            result += 1
        }
        return result
    }
}

// ---------------------------------------------------------------------------
// Solution Specific I/O

class GradeParser {
    private let parser: LineParser

    init(input: LineParser) {
        self.parser = input
    }

    func parseGrades() -> [Grade] {
        let gradeCount = parser.parseLine()
        var grades: [Grade] = []
        grades.reserveCapacity(gradeCount)
        for _ in 1...gradeCount {
            grades.append(Grade(score: parser.parseLine()))
        }
        return grades
    }
}

class GradeWriter {
    private let writer: Writer

    init(output: Writer) {
        self.writer = output
    }

    func writeGrades(_ grades: [Grade]) {
        for grade in grades {
            writer.writeLine(grade)
        }
    }
}

// ---------------------------------------------------------------------------
// I/O Framework

protocol LineParser {
    func parseLine() -> Int
}

protocol Writer {
    func writeLine(_ value: Any)
}

class StdIn: LineParser {
  private init() {}
  static let instance = StdIn()

  func parseLine() -> String {
    return readLine()!
  }

  func parseLine() -> Int {
    let line: String = parseLine()
    return Int(line)!
  }
}

class StdOut: Writer {
  private init() {}
  static let instance = StdOut()

  func writeLine(_ value: Any) {
    print(value)
  }
}

// ---------------------------------------------------------------------------
// Main

let solution = Solution(input: StdIn.instance, output: StdOut.instance)
solution.run()
