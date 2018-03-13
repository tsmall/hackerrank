package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
)

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

func parseFloat(scanner *bufio.Scanner, description string) float64 {
	parseFn := func(s string) (interface{}, error) {
		return strconv.ParseFloat(s, 64)
	}

	value := getNextInput(scanner, parseFn, description)
	return value.(float64)
}

func parseUint(scanner *bufio.Scanner, description string) uint64 {
	parseFn := func(s string) (interface{}, error) {
		return strconv.ParseUint(s, 10, 64)
	}

	value := getNextInput(scanner, parseFn, description)
	return value.(uint64)
}

func parseInput(input io.Reader) (mealCost float64, tipPercent, taxPercent uint64) {
	scanner := bufio.NewScanner(input)

	mealCost = parseFloat(scanner, "meal cost")
	tipPercent = parseUint(scanner, "tip percent")
	taxPercent = parseUint(scanner, "tax percent")

	return
}

func printResults(out io.Writer, totalCost float64) {
	fmt.Fprintf(out, "The total meal cost is %.0f dollars.", totalCost)
}

func calculateTotalCost(mealCost float64, tipPercent, taxPercent uint64) float64 {
	tip := mealCost * (float64(tipPercent) / 100)
	tax := mealCost * (float64(taxPercent) / 100)
	return mealCost + tip + tax
}

func main() {
	mealCost, tipPercent, taxPercent := parseInput(os.Stdin)
	totalCost := calculateTotalCost(mealCost, tipPercent, taxPercent)
	printResults(os.Stdout, totalCost)
}
