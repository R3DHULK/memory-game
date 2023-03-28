package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"
)

func main() {
	reader := bufio.NewReader(os.Stdin)

	// Set up game
	rand.Seed(time.Now().UnixNano())
	cards := []string{"A", "A", "B", "B", "C", "C", "D", "D", "E", "E"}
	rand.Shuffle(len(cards), func(i, j int) {
		cards[i], cards[j] = cards[j], cards[i]
	})
	shownCards := make([]bool, len(cards))
	numMatches := 0

	// Play game
	fmt.Println("Let's play Memory Card Game!")
	for {
		// Show board
		fmt.Println("-----")
		for i, card := range cards {
			if shownCards[i] {
				fmt.Printf("%s ", card)
			} else {
				fmt.Print("* ")
			}
			if (i+1)%5 == 0 {
				fmt.Println()
			}
		}
		fmt.Println("-----")

		// Get player choices
		var choices [2]int
		for i := 0; i < 2; i++ {
			fmt.Printf("Enter choice #%d (0-9): ", i+1)
			choice, err := reader.ReadString('\n')
			if err != nil {
				fmt.Println("Error reading input:", err)
				continue
			}
			choice = strings.TrimSpace(choice)
			choiceIndex := -1
			if len(choice) == 1 {
				choiceIndex = int(choice[0] - '0')
			}
			if choiceIndex < 0 || choiceIndex >= len(cards) {
				fmt.Println("Invalid choice, please enter a number between 0 and 9.")
				i--
				continue
			}
			if shownCards[choiceIndex] {
				fmt.Println("That card has already been shown, please choose another.")
				i--
				continue
			}
			choices[i] = choiceIndex
		}

		// Show chosen cards
		for _, choice := range choices {
			shownCards[choice] = true
			fmt.Printf("%s ", cards[choice])
		}
		fmt.Println()

		// Check for match
		if cards[choices[0]] == cards[choices[1]] {
			numMatches++
			fmt.Println("Match!")
			if numMatches == len(cards)/2 {
				fmt.Println("Congratulations, you won!")
				return
			}
		} else {
			fmt.Println("No match.")
			shownCards[choices[0]] = false
			shownCards[choices[1]] = false
		}
	}
}
