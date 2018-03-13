package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	// Input
	reader := bufio.NewReader(os.Stdin)
	input, _ := reader.ReadString('\n')

	// Output
	fmt.Println("Hello, World.")
	fmt.Println(input)
}
