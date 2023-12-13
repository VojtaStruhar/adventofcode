package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	trees := ParseInput("input.txt")
	task1(trees)
}

func task1(trees [][]int) {
	height := len(trees)
	width := len(trees)

	visibility_matrix := make([][]bool, len(trees))
	for i := 0; i < height; i++ {
		visibility_matrix[i] = make([]bool, width)
	}

	// Left to right
	for y := 0; y < height; y++ {
		row := trees[y]
		highest_yet := -1
		for x := 0; x < width; x++ {
			tree := row[x]

			if tree > highest_yet {
				visibility_matrix[y][x] = true
				highest_yet = tree
			}
		}
	}

	// Right to left
	for y := 0; y < height; y++ {
		row := trees[y]
		highest_yet := -1
		for x := width - 1; x >= 0; x-- {
			tree := row[x]

			if tree > highest_yet {
				visibility_matrix[y][x] = true
				highest_yet = tree
			}
		}
	}

	// Top to bottom
	for x := 0; x < width; x++ {
		highest_yet := -1
		for y := 0; y < height; y++ {
			tree := trees[y][x]

			if tree > highest_yet {
				highest_yet = tree
				visibility_matrix[y][x] = true
			}
		}
	}

	// Bottom to top
	for x := 0; x < width; x++ {
		highest_yet := -1
		for y := height - 1; y >= 0; y-- {
			tree := trees[y][x]

			if tree > highest_yet {
				highest_yet = tree
				visibility_matrix[y][x] = true
			}
		}
	}

	visibility_sum := 0
	for y := 0; y < height; y++ {
		for x := 0; x < width; x++ {
			if visibility_matrix[y][x] {
				visibility_sum++
			}
		}
	}

	fmt.Println("Total visible trees:", visibility_sum)
}

func ParseInput(filename string) [][]int {
	file, _ := os.Open(filename)
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanBytes)

	matrix := [][]int{make([]int, 0)}
	row := 0

	for scanner.Scan() {
		letter := scanner.Bytes()[0]
		number := int(letter) - int('0')

		if number < 0 || number > 9 {
			// Newline or something
			row++
			matrix = append(matrix, make([]int, 0, len(matrix[0])))
			continue
		}
		matrix[row] = append(matrix[row], number)
	}

	return matrix
}

func PrintMatrix(matrix [][]int) {
	for _, row := range matrix {
		fmt.Println(row)
	}
}

// Prints "x" instead of false
func PrintBoolMatrix(matrix [][]bool) {
	for i := 0; i < len(matrix); i++ {
		row := matrix[i]
		fmt.Print("|")
		for j := 0; j < len(row); j++ {
			if row[j] {
				fmt.Print(" ")
			} else {
				fmt.Print("x")
			}
			if j != len(row)-1 {
				fmt.Print(" ")
			}
		}
		fmt.Println("|")
	}
}
