package main

import (
	"errors"
	"fmt"
	"strings"
)

// Parsed from the input file.
// Example: move 1 from 2 to 1
type Instruction struct {
	source      int
	destination int
	count       int
}

type Supplies struct {
	crates [][]rune
}

/*
	IMPLEMENTATION OF SUPPLIES OPERATIONS
*/

func (supplies *Supplies) Add(crate rune, stack int) {
	supplies.EnsureStacks(stack + 1)
	supplies.crates[stack] = append(supplies.crates[stack], crate)
}

// Used when constructing the supplies from the input file
func (supplies *Supplies) AddBottom(crate rune, stack int) {
	supplies.EnsureStacks(stack + 1)
	supplies.crates[stack] = append([]rune{crate}, supplies.crates[stack]...)
}

func (supplies *Supplies) Pop(stack_i int) (rune, error) {
	if len(supplies.crates[stack_i]) == 0 {
		return '-', errors.New("cannot pop() an empty array")
	}
	result := supplies.crates[stack_i][len(supplies.crates[stack_i])-1]
	// remove last element
	supplies.crates[stack_i] = supplies.crates[stack_i][:len(supplies.crates[stack_i])-1]
	return result, nil
}

func (supplies *Supplies) Move(source int, destination int) {
	transfered, err := supplies.Pop(source)
	if err != nil {
		fmt.Println("Move error:", err)
		return
	}
	supplies.Add(transfered, destination)
}

func (supplies *Supplies) EnsureStacks(count int) {
	for len(supplies.crates) < count {
		supplies.crates = append(supplies.crates, []rune{})
	}
}

func (supplies *Supplies) StackTops() string {
	result := new(strings.Builder)
	for _, stack := range supplies.crates {
		result.WriteRune(stack[len(stack)-1])
	}

	return result.String()
}

func (supplies *Supplies) Perform(inst *Instruction) {
	for i := 0; i < inst.count; i++ {
		supplies.Move(inst.source-1, inst.destination-1)
	}
}

func (supplies *Supplies) PrettyPrint() {
	highest_stack := 0
	// Get the tallest stack
	for _, stack := range supplies.crates {
		if len(stack) > highest_stack {
			highest_stack = len(stack)
		}
	}

	for print_height := highest_stack - 1; print_height >= 0; print_height -= 1 {
		for _, stack := range supplies.crates {
			if len(stack) > print_height {
				fmt.Printf("[%c] ", stack[print_height])
			} else {
				fmt.Printf("    ")
			}
		}
		fmt.Print("\n")
	}

	fmt.Print(" ")
	for i := 0; i < len(supplies.crates); i++ {
		fmt.Printf("%d   ", i+1)
	}
	fmt.Print("\n")

}
