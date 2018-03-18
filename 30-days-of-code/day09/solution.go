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
	f := factorial(n)
	printResults(os.Stdout, f)
}

// --------------------------------------------------------------------
// Computation

func factorial(n uint64) uint64 {
	if n == 1 {
		return 1
	}
	return n * factorial(n - 1)
}

// --------------------------------------------------------------------
// Input/Output

func parseInput(input io.Reader) uint64 {
	scanner := bufio.NewScanner(input)
	return parseUint(scanner, "n")
}

func printResults(out io.Writer, factorial uint64) {
	fmt.Fprintf(out, "%d\n", factorial)
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
