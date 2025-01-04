package day1

import "core:fmt"
import "core:os"
import "core:sort"
import "core:strconv"
import "core:strings"

read_input :: proc(filepath: string, list_a: ^[dynamic]int, list_b: ^[dynamic]int) {
	data, ok := os.read_entire_file(filepath, context.allocator)
	if !ok {
		fmt.println("Could not read file.")
		return
	}
	defer delete(data, context.allocator)

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		a_int, a_ok := strconv.parse_int(strings.cut(line, 0, 5))
		if !a_ok {fmt.println("Couldn't parse in for list_a")}
		b_int, b_ok := strconv.parse_int(strings.cut(line, 8, 5))
		if !b_ok {fmt.println("Couldn't parse in for list_b")}

		append(list_a, a_int)
		append(list_b, b_int)
	}
}

calc_similarity_score :: proc(list_a: ^[dynamic]int, list_b: ^[dynamic]int) -> int {
	left_list := make([dynamic]int, len(list_a), cap(list_a))
	right_list := make([dynamic]int, len(list_b), cap(list_b))
	defer delete(left_list)
	defer delete(right_list)

	copy(left_list[:], list_a[:])
	copy(right_list[:], list_b[:])

	sim_score: int = 0

	for i in 0 ..< len(left_list) {
		right_duplicates: int = 0

		for j in 0 ..< len(right_list) {
			if left_list[i] == right_list[j] {right_duplicates += 1}
		}

		left_list[i] = left_list[i] * right_duplicates
		sim_score += left_list[i]
	}

	return sim_score
}

main :: proc() {
	list_a, list_b: [dynamic]int
	read_input("input.txt", &list_a, &list_b)
	sort.quick_sort(list_a[:])
	sort.quick_sort(list_b[:])

	total_distance: int = 0
	for i in 0 ..< len(list_a) {
		total_distance += abs(list_a[i] - list_b[i])
	}
	// part 1 answer
	fmt.println("Part 1 Answer: ", total_distance)

	// part 2 answer
	fmt.println("Part 2 Answer: ", calc_similarity_score(&list_a, &list_b))

}
