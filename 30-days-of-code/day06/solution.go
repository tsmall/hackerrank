package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"strconv"
)

func main() {
	strings := getInputStrings(os.Stdin)
	splits := splitStrings(strings)
	printResults(os.Stdout, splits)
}

// --------------------------------------------------------------------
// Computation

type split struct {
	evens string
	odds string
}

func splitStrings(strings chan string) chan split {
	out := make(chan split)

	go func() {
		for s := range strings {
			out <- splitString(s)
		}
		close(out)
	}()

	return out
}

func splitString(s string) split {
	var evens bytes.Buffer
	var odds bytes.Buffer
	for i, r := range s {
		if isEven(i) {
			evens.WriteRune(r)
		} else {
			odds.WriteRune(r)
		}
	}
	return split{evens: evens.String(), odds: odds.String()}
}

func isEven(n int) bool {
	return n % 2 == 0
}

// --------------------------------------------------------------------
// Input/Output

func getInputStrings(input io.Reader) (chan string) {
	out := make(chan string)

	go func() {
		scanner := bufio.NewScanner(input)
		wordCount := parseUint(scanner, "word count")

		var i uint64
		for i = 0; i < wordCount; i++ {
			scanner.Scan()
			word := scanner.Text()
			out <- word
		}
		close(out)
	}()

	return out
}

func printResults(out io.Writer, splits chan split) {
	for split := range splits {
		fmt.Fprintf(out, "%s %s\n", split.evens, split.odds)
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
