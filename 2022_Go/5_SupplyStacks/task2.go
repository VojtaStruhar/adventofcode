package main

type CrateMover9001 struct {
	supplies *Supplies
}

func (crane *CrateMover9001) Perform(inst *Instruction) {
	to_move := []rune{}
	for i := 0; i < inst.count; i++ {
		crate, _ := crane.supplies.Pop(inst.source)
		to_move = append(to_move, crate)
	}

	for i := len(to_move) - 1; i >= 0; i-- {
		crane.supplies.Add(to_move[i], inst.destination)
	}
}

func (crane *CrateMover9001) SetSupplies(supplies *Supplies) {
	crane.supplies = supplies
}
