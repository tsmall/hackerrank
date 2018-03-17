func (p person) NewPerson(initialAge int) person {
	if p.age < 0 {
		fmt.Println("Age is not valid, setting age to 0.")
		return person{age: 0}
	}
	return p
}

func (p person) amIOld() {
	switch {
	case p.age < 13:
		fmt.Println("You are young.")
	case p.age < 18:
		fmt.Println("You are a teenager.")
	default:
		fmt.Println("You are old.")
	}
}

func (p person) yearPasses() person {
	return person{age: p.age + 1}
}
