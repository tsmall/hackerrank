import Foundation


class Person {
    private let firstName: String
    private let lastName: String
    private let id: Int

    // Initializer
    init(firstName: String, lastName: String, id: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }

    // Print person data
    func printPerson() {
        print("Name: \(lastName), \(firstName)")
        print("ID: \(id)")
    }
}


class Student: Person {
    private let scores: ScoreCollection

    init(firstName: String, lastName: String, id: Int, scores: [Int]) {
        self.scores = ScoreCollection(scores: scores, scale: GradeScale.potterScale)
        super.init(firstName: firstName, lastName: lastName, id: id)
    }

    func calculate() -> Character {
        return scores.averageLetterGrade
    }
}


struct ScoreCollection {
    let scores: [Int]
    let scale: GradeScale

    var averageNumericGrade: Int {
        return scores.sum() / scores.count
    }

    var averageLetterGrade: Character {
        return scale.letterGrade(forScore: averageNumericGrade)!
    }
}


typealias GradeScaleCriterion = (minGrade: Int, maxGrade: Int, letter: Character)


class GradeScale {
    static var potterScale: GradeScale {
        let scale = GradeScale()
        scale.addCriteria([
            (minGrade: 90, maxGrade: 100, letter: "O"),
            (minGrade: 80, maxGrade:  89, letter: "E"),
            (minGrade: 70, maxGrade:  79, letter: "A"),
            (minGrade: 55, maxGrade:  69, letter: "P"),
            (minGrade: 40, maxGrade:  54, letter: "D"),
            (minGrade:  0, maxGrade:  39, letter: "T"),
        ])
        return scale
    }

    private var criteria: [GradeScaleCriterion] = []

    func addCriteria(_ criteria: [GradeScaleCriterion]) {
        self.criteria = criteria
    }

    func letterGrade(forScore score: Int) -> Character? {
        for criterion in criteria {
            if score >= criterion.minGrade && score <= criterion.maxGrade {
                return criterion.letter
            }
        }
        return nil
    }
}


extension Array where Element : Numeric {
  func sum() -> Element {
    return self.reduce(0, { $0 + $1 })
  }
}


let nameAndID = readLine()!.components(separatedBy: " ")
let _ = readLine()
let scores = readLine()!.components(separatedBy: " ").map{ Int($0)! }

let s = Student(firstName: nameAndID[0], lastName: nameAndID[1], id: Int(nameAndID[2])!, scores: scores)

s.printPerson()

print("Grade: \(s.calculate())")
