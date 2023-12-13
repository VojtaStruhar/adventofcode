package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

var TOTAL_SPACE int = 70_000_000
var REQUIRED_SPACE int = 30_000_000

func main() {
	filesystem := ParseInput("input.txt")

	dirs := filesystem.root.GetDirectoriesRecursive()
	{ // Task 1
		sizeSum := 0

		for _, dir := range dirs {
			size := dir.GetSize()
			if size < 100_000 {
				sizeSum += size
			}
		}

		fmt.Println("Task 1: Sum of directory sizes under 100_000:", sizeSum)
	}

	{ // Task 2
		current_free_space := TOTAL_SPACE - filesystem.root.GetSize()
		minimum_space_needed := REQUIRED_SPACE - current_free_space

		smallest_possible_dir := filesystem.root
		smallest_possible_dir_size := smallest_possible_dir.GetSize()

		fmt.Println("Currently the device has", current_free_space, "free space - we need", minimum_space_needed, "more!")

		for _, dir := range dirs {
			size := dir.GetSize()
			if size > minimum_space_needed && size < smallest_possible_dir_size {
				smallest_possible_dir = dir
				smallest_possible_dir_size = size
			}
		}

		fmt.Println("Task 2: Directory", smallest_possible_dir.name, "is the ideal candidate with size of", smallest_possible_dir_size)
	}

}

func ParseInput(filename string) *FileSystem {
	file, _ := os.Open(filename)
	reader := bufio.NewReader(file)

	filesystem := NewFileSystem()
	current := filesystem.root

	for {
		line, err := reader.ReadString('\n')
		if err != nil {
			break
		}

		words := strings.Split(line, " ")
		if words[0] == "$" {
			command := Strip(words[1])
			switch command {
			case "ls":
				lsCommand(reader, current)
			case "cd":
				arg := Strip(words[2])
				if arg == "/" {
					current = filesystem.root
					break
				}
				node, err := current.cd(arg)
				if err != nil {
					fmt.Println("cd error:", err)
					break
				}
				current = node
			default:
				fmt.Println("Unknown command", command)
			}
		}

	}
	return filesystem
}

func lsCommand(reader *bufio.Reader, cwd *INode) {
	for {
		bytes, peekError := reader.Peek(1)
		if peekError != nil {
			return
		}
		if bytes[0] == '$' {
			return
		}

		line, readstringError := reader.ReadString('\n')
		if readstringError != nil {
			return
		}

		line = Strip(line)
		words := strings.Split(line, " ")
		size, parseError := strconv.Atoi(words[0])
		name := words[1]
		if parseError != nil {
			// Dir
			cwd.mkdir(name)
		} else {
			cwd.touch(name, int(size))
		}
	}
}

func Strip(text string) string {
	return strings.Trim(text, " \n")
}
