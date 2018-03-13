package main

import (
	"fmt"
	"os"
	"bufio"
	"strconv"
)

func main() {
	var _ = strconv.Itoa // Ignore this comment. You can still use the package "strconv".

	var i uint64 = 4
	var d float64 = 4.0
	var s string = "HackerRank "

	scanner := bufio.NewScanner(os.Stdin)

	// Declare second integer, double, and String variables.
	var i_input uint64
	var d_input float64
	var s_input string

	// Read and save an integer, double, and String to your variables.
	scanner.Scan()
	input := scanner.Text()
	i_input, err := strconv.ParseUint(input, 10, 64)
	if err != nil {
		panic(fmt.Sprintf("Invalid int: %v", input))
	}

	scanner.Scan()
	input = scanner.Text()
	d_input, err = strconv.ParseFloat(input, 64)
	if err != nil {
		panic(fmt.Sprintf("Invalid float: %v", input))
	}

	scanner.Scan()
	s_input = scanner.Text()

	// Print the sum of both integer variables on a new line.
	fmt.Println(i + i_input)

	// Print the sum of the double variables on a new line.
	fmt.Printf("%.1f\n", d + d_input)

	// Concatenate and print the String variables on a new line
	// The 's' variable above should be printed first.
	fmt.Println(s + s_input)
}
