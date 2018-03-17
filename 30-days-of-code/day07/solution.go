package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
)

func main() {
	array := parseInput(os.Stdin)
	reversed := reverse(array)
	printEach(os.Stdout, reversed)
}

// --------------------------------------------------------------------
// Computation

func reverse(array []uint64) []uint64 {
	reversed := make([]uint64, len(array))
	for i := 0; i < len(array); i++ {
		reversed[i] = array[ len(array) - i - 1 ]
	}
	return reversed
}

// --------------------------------------------------------------------
// Input/Output

func parseInput(input io.Reader) []uint64 {
	scanner := bufio.NewScanner(input)
	scanner.Split(bufio.ScanWords)

	arrayLength := parseUint(scanner, "array length")

	array := make([]uint64, arrayLength)
	var i uint64
	for i = 0; i < arrayLength; i++ {
		array[i] = parseUint(scanner, fmt.Sprintf("element #%d", i))
	}

	return array
}

func printEach(out io.Writer, array []uint64) {
	for _, each := range array {
		fmt.Printf("%d ", each)
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
