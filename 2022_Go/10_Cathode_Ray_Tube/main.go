package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {

    file, err := os.Open("input.txt")
    defer file.Close()

    if err != nil {
        fmt.Println(err)
        return
    }

    scanner := bufio.NewScanner(file)
    cpu := NewCPU()

    for scanner.Scan() {
        line := scanner.Text()
        parts := strings.Split(line, " ")
        
        if len(parts) == 1 && parts[0] == "noop" { 
            cpu.Noop()

        } else if len(parts) == 2 && parts[0] == "addx" {
            val, err := strconv.Atoi(parts[1])
            if err != nil {
                fmt.Println(err)
                continue
            }
            cpu.Addx(val)
        } else {
            fmt.Println("Unknown instruction:", line)
        }
    }
  
    fmt.Println("Program loaded into memory")

    for cpu.Process() {
        draw_pos := (cpu.cycles - 1) % 40

        if draw_pos == 0 {
            fmt.Println("|")
            fmt.Print("|")
        }
        if abs(draw_pos - cpu.regx) < 2 {
            fmt.Print(" ")
        } else {
            fmt.Print("#")
        }
    }

    fmt.Println()
}

func abs(n int) int {
    if n < 0 {
        return -n
    }
    return n
}

type Instruction int64

const (
	Noop Instruction = iota
	Addx 
)

func (inst Instruction) Cost() int {
    if inst == Addx {
        return 2
    }

    return 1
}

type Command struct {
    instr Instruction
    arg1 int
}

type CPU struct {
    program []Command
    
    command_pointer int
    command_progress int
    cycles int

    regx int
}

func NewCPU() *CPU {

    cpu := new(CPU)
    cpu.program = make([]Command, 0)
    cpu.command_pointer = -1
    cpu.regx = 1

    return cpu
}

func (cpu *CPU) Process() bool {
    if cpu.command_pointer == -1 {
        // Initialize the cpu
        cpu.nextCommand()
    }

    if cpu.command_progress == 0 {
        // Execute current command
        cmd := cpu.program[cpu.command_pointer]
        if cmd.instr == Addx {
            cpu.regx += cmd.arg1
        }

        // Load next command
        cpu.nextCommand()
    }
    
    cpu.command_progress -= 1
    cpu.cycles += 1

    return cpu.command_pointer < len(cpu.program)
}


func (cpu *CPU) nextCommand() {
    cpu.command_pointer++
    if cpu.command_pointer < len(cpu.program) {
        cpu.command_progress = cpu.program[cpu.command_pointer].instr.Cost()
    }

}

func (cpu *CPU) SignalStrength() int {
    return cpu.cycles * cpu.regx
}

func (cpu *CPU) Addx(val int) {
    cpu.program = append(cpu.program, Command{Addx, val})
}

func (cpu *CPU) Noop() {
    cpu.program = append(cpu.program, Command{Noop, 0})
}

