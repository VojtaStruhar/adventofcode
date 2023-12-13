package main

type CrateMover9000 struct {
	supplies *Supplies
}

func (crane *CrateMover9000) Perform(inst *Instruction) {
	for i := 0; i < inst.count; i++ {
		crane.supplies.Move(inst.source, inst.destination)
	}
}

func (crane *CrateMover9000) SetSupplies(supplies *Supplies) {
	crane.supplies = supplies
}
