#!/usr/bin/env bash

declare -a test_runners=("tape" "jest" "mocha-webpack" "karma-mocha" "ava")

declare -a test_files=("Basic1" "Basic2" "Basic3" "Basic4" "Basic5" "Basic6" "Basic7" "Basic8" "Parent")

remove_temp_directories() {
	for test_runner in "${test_runners[@]}"; do
		rm -rf "${test_runner}-temp"
	done
}

generate_test_files() {
	for ((i = 0; i < $1; i++)); do
		test_file=${test_files[$((i % ${#test_files[@]}))]}
		cp "${test_file}.spec.js" "${test_file}-${i}.spec.js"
	done
}

remove_test_files() {
	for ((i = 0; i < $1; i++)); do
		rm "${test_files[$((i % ${#test_files[@]}))]}-${i}.spec.js"
	done
}

get_average_time_of_tests() {
	local sum
	local average
	generate_test_files $1
	TIMEFORMAT=%R
	declare -a results_arr
	for i in {1..3}; do
		process_time=$(time (yarn test >/dev/null 2>&1) 2>&1)
		results_arr[$i]=$process_time
	done
	sum="$(echo "${results_arr[1]} + ${results_arr[2]} + ${results_arr[3]}" | bc)"
	average="$(echo "scale=2; $sum / 3" | bc -l)"
	remove_test_files "$1"
	echo "$average"
}

get_average_memory_usage_of_tests() {
	local sum
	local average
	generate_test_files $1
	TIMEFORMAT=%R
	declare -a results_arr
	for i in {1..3}; do
		process_mem=$(/usr/bin/time -f '%M' yarn test 2>&1 | tail -n 1)
		results_arr[$i]=$process_mem
	done
	sum="$(echo "${results_arr[1]} + ${results_arr[2]} + ${results_arr[3]}" | bc)"
	average="$(echo "scale=2; $sum / 3" | bc -l)"
	remove_test_files "$1"
	echo "$average"
}

generate_table_row() {
	local test_runner="$1"
	local time_1
	local time_10
	local time_100
	local time_1000
	cp -R "${test_runner}" "${test_runner}-temp"
	cd "${test_runner}-temp" || echo "failed to change into ./${test_runner}-temp"
	echo "getting average of 1 test in $test_runner ..."
	time_1=$(get_average_time_of_tests 1 "$test_runner")
	echo "getting average of 10 tests in $test_runner ..."
	time_10=$(get_average_time_of_tests 10 "$test_runner")
	echo "getting average of 100 tests in $test_runner ..."
	time_100=$(get_average_time_of_tests 100)
	echo "getting average of 1000 tests in $test_runner ..."
	time_1000=$(get_average_time_of_tests 1000)
	echo "getting memory usage of $test_runner ..."
	mem_1000=$(get_average_memory_usage_of_tests 1000)
	echo "done, generating results row for $test_runner ..."
	printf "| %-14s | %-9ss | %-9ss | %-9ss | %-9ss | %-10s |\n" $test_runner $time_1 $time_10 $time_100 $time_1000 $mem_1000 >> ../RESULTS.md
}

run_tests() {
	cp results.template RESULTS.md

	for test_runner in "${test_runners[@]}"; do (
		generate_table_row "$test_runner"
	)
	done

	remove_temp_directories
}

remove_temp_directories
run_tests

trap remove_temp_directories EXIT INT TERM
