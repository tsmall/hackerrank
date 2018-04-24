import Foundation

// BEGIN MY CODE

struct Printer<T> {

    /**
     * Prints each element of the generic array on a new line.
     */
    func printArray(array: [T]) {
        for each in array {
            print(each)
        }
    }

}

// END MY CODE

var n = Int(readLine()!)!
var intArray = Array(repeating: 0, count: n);
for i in 0...n - 1 {
    intArray[i] = Int(readLine()!)!;
}

n = Int(readLine()!)!
var stringArray = Array(repeating: "", count: n);
for i in 0...n - 1 {
    stringArray[i] = readLine()!;
}

Printer<Int>().printArray(array: intArray)
Printer<String>().printArray(array: stringArray)
