package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
)

func main() {
	n := parseInput(os.Stdin)
	judgment := judgeNumber(n)
	printResults(os.Stdout, judgment)
}

// --------------------------------------------------------------------
// Computation

func judgeNumber(n uint64) string {
	switch {
	case isOdd(n):
		return "Weird"
	case n >= 2 && n <= 5:
		return "Not Weird"
	case n >= 6 && n <= 20:
		return "Weird"
	default:
		return "Not Weird"
	}
}

func isOdd(n uint64) bool {
	return n % 2 != 0
}

// --------------------------------------------------------------------
// Input/Output

func parseInput(input io.Reader) uint64 {
	scanner := bufio.NewScanner(input)
	return parseUint(scanner, "number")
}

func printResults(out io.Writer, judgment string) {
	fmt.Println(judgment)
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
