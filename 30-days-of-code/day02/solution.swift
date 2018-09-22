// This program calculates the total cost of a meal
// given the cost (a double)
// plus the tax and tip percentages (integers).
// Let's call the combination of those three values a "bill",
// which we'll represent as a structure.

struct Bill {
  let cost: Double
  let tipPercent: Int
  let taxPercent: Int
}

// Our Bill objects are smart;
// they know how to compute their own tip and tax
// and also their total cost,
// the single number that includes the tip and tax.

extension Bill {
  var tip: Double {
    return cost * Double(tipPercent) / 100.0
  }

  var tax: Double {
    return cost * Double(taxPercent) / 100.0
  }

  var total: Double {
    return cost + tip + tax
  }
}

// The specific amounts for the bill are provided to this program via stdin.
// The first line contains a string representing the cost,
// the second a string representing the tip percentage,
// and the third a string representing the tax percentage.
// This function parses the input and returns the results as a Bill.

func parseInput() -> Bill {
  guard let costString = readLine() else {
    fatalError("Unable to read cost")
  }
  guard let tipString = readLine() else {
    fatalError("Unable to read tip percent")
  }
  guard let taxString = readLine() else {
    fatalError("Unable to read tax percent")
  }

  guard let cost = Double(costString) else {
    fatalError("Unable to parse cost")
  }
  guard let tip = Int(tipString) else {
    fatalError("Unable to parse tip percent")
  }
  guard let tax = Int(taxString) else {
    fatalError("Unable to parse tax percent")
  }

  return Bill(cost: cost, tipPercent: tip, taxPercent: tax)
}

// With everything in place
// we're now able to read from the input
// and print the total cost,
// rounded to the nearest integer.

let bill = parseInput()
print("The total meal cost is \(Int(bill.total.rounded())) dollars.")
