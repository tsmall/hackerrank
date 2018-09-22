var i = 4
var d = 4.0
var s = "HackerRank "

// This program starts with the three variables defined above:
// i, an integer; d, a double; and s, a string. We'll use those
// variables in our computation below.

// First, we read an integer from stdin, add that to the
// integer defined above, and print the result.
if let input = readLine() {
  if let input_i = Int(input) {
    print(i + input_i)
  }
}

// Next, we read a double from stdin, add that to the double
// defined above, and print the result.
if let input = readLine() {
  if let input_d = Double(input) {
    print(d + input_d)
  }
}

// And lastly, we read a string, concatenate it to the string
// defined above, and print the result.
if let input = readLine() {
  print(s + input)
}
