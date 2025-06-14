package main

import (
	"fmt"
)

func unused() {
	fmt.Println("bar")
}

func main() {
	fmt.Println("foo")
	go unused()

}
