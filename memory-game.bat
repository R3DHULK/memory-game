package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	fmt.Println("Welcome to Simon Says!")

	level := 1
	sequence := ""
	userSequence := ""

	for {
		fmt.Printf("\nLevel %d\n\n", level)

		// Generate the sequence
		for i := 1; i <= level; i++ {
			randomNum := rand.Intn(4) + 1
			if randomNum == 1 {
				sequence += "R"
			} else if randomNum == 2 {
				sequence += "G"
			} else if randomNum == 3 {
				sequence += "B"
			} else {
				sequence += "Y"
			}
		}

		// Display the sequence
		fmt.Printf("Simon says: %s\n", sequence)
		time.Sleep(2 * time.Second)

		// Get user input
		fmt.Println("\nYour turn:")
		fmt.Scanln(&userSequence)

		// Validate user input
		if userSequence == sequence {
			fmt.Println("Correct!")
			level++
			sequence = ""
			userSequence = ""
		} else {
			fmt.Printf("Incorrect. Game Over! Your final level is %d\n", level)
			return
		}
	}
}
