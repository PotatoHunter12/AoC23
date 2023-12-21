package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

main :: proc() {
    fmt.println("Answer 1:",getArea(1))
    fmt.println("Answer 2:",getArea(2))
}

getArea :: proc(part : int) -> (value : int) {
    filepath := string("Input/input18.txt")
	data, ok := os.read_entire_file(filepath, context.allocator)

    vertex: [dynamic][2]int
	it := string(data)
    x : int = 0
    y : int = 0
    C := 0
	for line in strings.split_lines_iterator(&it) {
        fakingodin,ok := strconv.parse_i128_of_base(strings.split(line," ")[2][2:7],16)

        direction := part == 1 ? strings.split(line," ")[0] : strings.split(line," ")[2][7:8]
        instruction := part == 1 ? strconv.atoi(strings.split(line," ")[1]) : int(fakingodin)

        switch direction{
            case "R" :fallthrough
            case "0":
                x += instruction
            case "D" :fallthrough
            case "1":
                y += instruction
            case "L" :fallthrough
            case "2":
                x-= instruction
            case "U" :fallthrough
            case "3":
                y -= instruction
        }
        
        C += instruction

        append(&vertex,[2]int{x,y})
	}
    
    append(&vertex,vertex[0])

    S := 0
    for i := 0; i < len(vertex)-1; i += 1 {
        v1 := vertex[i]
        v2 := vertex[i+1]
        S += v1[0] * v2[1] - v1[1] * v2[0]
    }
    
    return (S+C)/2+1
}