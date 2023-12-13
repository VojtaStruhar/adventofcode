package main

import (
	"bufio"
	"fmt"
	"os"
)

// Great video about this problem:
// https://www.youtube.com/watch?v=U16RnpV48KQ

func main() {

	file, _ := os.Open("input.txt")
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()

		packet_marker := distinctCharacters(line, 4)
		fmt.Println("Packet marker after char", packet_marker+4)

		message_marker := distinctCharacters(line, 14)
		fmt.Println("Message marker after char", message_marker+14)

	}
}

func distinctCharacters(message string, count int) int {

	window_start := 0

window_loop:
	for window_start < len(message) {
		// This is not a slice, so no appending
		var set uint32 = 0

		// Iterate backwards for longer potential skips
		for i := count - 1; i >= 0; i-- {
			letter := message[window_start+i]
			var letter_bit_representation uint32 = 1 << (int(letter) % 32)

			// Check if we've seen this letter already
			if set&letter_bit_representation != 0 {
				// By iterating backwards, you can skip the whole remaining
				// _prefix_ as soon as you encounter a duplicate
				window_start += i + 1
				continue window_loop
			}

			// Put the letter into the set
			set = set | letter_bit_representation
		}
		return window_start
	}

	return -1
}

// Kinda normal implementation - upgrade from a map (hashset) to an array
func distinctCharactersWithArray(message string, count int) int {

	index := 0
window_loop:
	for index < len(message) {
		// This is not a slice, so no appending
		set := make([]byte, count)

		for i := 0; i < count; i++ {
			letter := message[index+i]

			if contains(set, letter) {
				index++
				continue window_loop
			}

			set[i] = letter
		}
		return index
	}

	return -1
}

func contains(arr []byte, element byte) bool {
	for _, val := range arr {
		if val == element {
			return true
		}
	}
	return false
}
