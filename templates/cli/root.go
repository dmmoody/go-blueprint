package cli

import (
	"fmt"
	"os"
)

func Run() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: app <command>")
		return
	}

	switch os.Args[1] {
	case "version":
		fmt.Println("v0.0.1")
	default:
		fmt.Printf("Unknown command: %s\n", os.Args[1])
	}
}
