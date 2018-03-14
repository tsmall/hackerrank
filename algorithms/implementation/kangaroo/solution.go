package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
)

func main() {
	roo1, roo2 := parseInput(os.Stdin)
	result := canMeet(roo1, roo2)
	printResults(os.Stdout, result)
}

// --------------------------------------------------------------------
// Types

type kangaroo struct {
	x uint64
	v uint64
}

// --------------------------------------------------------------------
// Computation

func canMeet(roo1, roo2 kangaroo) bool {
	if roo1.atSamePositionAs(roo2) {
		return true
	}
	back, front := roo1.orderedAgainst(roo2)
	if !back.canCatch(front) {
		return false
	}
	advanceUntilCrossed(&back, &front)
	return back.atSamePositionAs(front)
}

func (x kangaroo) atSamePositionAs(y kangaroo) bool {
	return x.x == y.x
}

func (x kangaroo) orderedAgainst(y kangaroo) (back, front kangaroo) {
	if x.x < y.x {
		return x, y
	} else {
		return y, x
	}
}

func (back kangaroo) canCatch(front kangaroo) bool {
	return back.v > front.v
}

func advanceUntilCrossed(back, front *kangaroo) {
	for back.x < front.x {
		back.x += back.v
		front.x += front.v
	}
}

// --------------------------------------------------------------------
// Input/Output

func parseInput(input io.Reader) (kangaroo, kangaroo) {
	scanner := bufio.NewScanner(input)
	scanner.Split(bufio.ScanWords)

	x1 := parseUint(scanner, "x1")
	v1 := parseUint(scanner, "v1")
	x2 := parseUint(scanner, "x2")
	v2 := parseUint(scanner, "v2")

	return kangaroo{x: x1, v: v1}, kangaroo{x: x2, v: v2}
}

func printResults(out io.Writer, result bool) {
	if result {
		fmt.Println("YES")
	} else {
		fmt.Println("NO")
	}
}

// --------------------------------------------------------------------
// Framework

type parser func(input string) (interface{}, error)

func getNextInput(scanner *bufio.Scanner, parseFn parser, description string) interface{} {
	scanner.Scan()
	token := scanner.Text()
	value, err := parseFn(token)
	if err != nil {
		panic(fmt.Sprintf("invalid %s: %v", description, token))
	}
	return value
}

func parseUint(scanner *bufio.Scanner, description string) uint64 {
	parseFn := func(s string) (interface{}, error) {
		return strconv.ParseUint(s, 10, 64)
	}

	value := getNextInput(scanner, parseFn, description)
	return value.(uint64)
}
