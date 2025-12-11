package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

main :: proc() {
    // Read input file
    data, ok := os.read_entire_file("input.txt")
    if !ok {
        fmt.println("Error reading file")
        return
    }
    // Free memory after reading file
    defer delete(data)

    content := string(data)
    lines := strings.split_lines(content)
    // Free memory after splitting lines
    defer delete(lines)

    pos := 50
    number_of_zeroes := 0

    for line in lines {
        trimmed := strings.trim_space(line)
        if len(trimmed) == 0 do continue

        // Rune is Unicode code point — a single character represented as an integer under the hood
        dir := rune(trimmed[0])
        amount := strconv.parse_int(trimmed[1:]) or_else 0

        for i := 0; i < amount; i += 1 {
            if dir == 'L' {
                pos = (pos - 1 + 100) % 100
            } else if dir == 'R' {
                pos = (pos + 1) % 100
            }

            if pos == 0 do number_of_zeroes += 1
        }
    }

    fmt.println("Number of zeroes:", number_of_zeroes)
}
