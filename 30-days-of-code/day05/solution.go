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

	out := make(chan multipleResult)
	go calculateMultiples(n, out)

	for each := range out {
		printMultiple(os.Stdout, each)
	}
}

// --------------------------------------------------------------------
// Computation

type multipleResult struct {
	number uint64
	multiple uint64
	result uint64
}

func calculateMultiples(n uint64, out chan multipleResult) {
	var result uint64
	var multiple uint64
	for multiple = 1; multiple <= 10; multiple++ {
		result = n * multiple
		out <- multipleResult{number: n, multiple: multiple, result: result}
	}
	close(out)
}

// --------------------------------------------------------------------
// Input/Output

func parseInput(input io.Reader) uint64 {
	scanner := bufio.NewScanner(input)
	return parseUint(scanner, "n")
}

func printMultiple(out io.Writer, r multipleResult) {
	fmt.Fprintf(out, "%d x %d = %d\n", r.number, r.multiple, r.result)
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
