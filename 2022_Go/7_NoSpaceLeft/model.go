package main

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
)

type FileSystem struct {
	root *INode
}

func NewFileSystem() *FileSystem {
	rootDir := NewRootDirectory("/")
	return &FileSystem{
		root: rootDir,
	}
}

func (fs *FileSystem) PrettyPrint() {
	fs.root.PrettyPrint(0)
}

func (dir *INode) mkdir(name string) {
	newdir := &INode{
		name:     name,
		size:     0,
		children: make([]*INode, 0),
		parent:   dir,
	}
	dir.children = append(dir.children, newdir)
}

func (dir *INode) cd(name string) (*INode, error) {
	if dir.isFile() {
		return nil, errors.New("Cannot cd on a file! " + dir.name)
	}

	if name == ".." {
		return dir.parent, nil
	}

	for _, v := range dir.children {
		if v.name == name {
			if v.isFile() {
				return nil, errors.New("cd: '" + name + "' is a file!")
			}
			return v, nil
		}
	}

	dir.mkdir(name)
	return dir.children[len(dir.children)-1], nil
}

type INode struct {
	name     string
	size     int
	parent   *INode
	children []*INode
}

func (node *INode) isDirectory() bool {
	return node.children != nil
}

func (node *INode) isFile() bool {
	return !node.isDirectory()
}

func (dir *INode) touch(name string, size int) error {
	if dir.isFile() {
		return errors.New("touch: " + dir.name + " is a file!")
	}
	file := &INode{
		name:     name,
		size:     size,
		children: nil,
		parent:   dir,
	}
	dir.children = append(dir.children, file)
	return nil
}

func NewRootDirectory(name string) *INode {
	dir := &INode{
		name:     name,
		size:     0,
		children: make([]*INode, 0),
	}
	dir.parent = dir
	return dir
}

func (node *INode) GetSize() int {
	if node.isFile() {
		return node.size
	}

	// Directories - recursive
	sum := 0
	for _, child := range node.children {
		sum += child.GetSize()
	}

	return sum
}

func (node *INode) GetDirectoriesRecursive() []*INode {
	if node.isFile() {
		return []*INode{}
	}

	result := []*INode{node}
	for _, child := range node.children {
		result = append(result, child.GetDirectoriesRecursive()...)
	}
	return result
}

func (node *INode) PrettyPrint(indent int) {
	builder := &strings.Builder{}
	for i := 0; i < indent; i++ {
		builder.WriteString("  ")
	}

	if node.isFile() {
		builder.WriteString("- " + node.name + " (" + strconv.FormatInt(int64(node.size), 10) + ")")
		fmt.Println(builder.String())
	} else {
		builder.WriteString("- " + node.name)
		fmt.Println(builder.String())
		for _, child := range node.children {
			child.PrettyPrint(indent + 1)
		}
	}
}
