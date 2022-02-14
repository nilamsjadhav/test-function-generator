#! /bin/bash

# Global variables
GREEN='\033[1;032m'
NORMAL='\033[0m'
RED='\033[6;031m'
WHITE="\033[1;37m"
FAIL_COUNT=0
TOTAL_COUNT=0
FAILED_DESCRIPTION=()
FAILED_ACTUAL=()
FAILED_EXPECTED=()
FUNCTION_NAMES=()

function save_failed_records() {
	local function_name="$1"
	local description="$2"
	local actual="$3"
	local expected="$4"

	FUNCTION_NAMES[$FAIL_COUNT]="${function_name}"
	FAILED_DESCRIPTION[$FAIL_COUNT]="${description}"
	FAILED_ACTUAL[$FAIL_COUNT]="${actual}"
	FAILED_EXPECTED[$FAIL_COUNT]="${expected}"
	FAIL_COUNT=$(( ${FAIL_COUNT} + 1 ))
}

function display_failed_records() {
	local index=0

	echo -e "\nTEST REPORT:"
	while [[ ${index} -lt ${FAIL_COUNT} ]]
	do
		echo -e "\n${FUNCTION_NAMES[$index]}\n\t${FAILED_DESCRIPTION[$index]}"
		echo -e "\n${RED}Actual:\n${FAILED_ACTUAL[$index]}"
		echo -e "\nExpected:\n${FAILED_EXPECTED[$index]}${NORMAL}"
		index=$(( ${index} + 1 ))
	done
	echo -e "\nFailed cases: ${FAIL_COUNT}/${TOTAL_COUNT}"
}

function assert_expectation() {
	local actual="$1"
	local expected="$2"
	local test_description="$3"
	local function_name="$4"

	local test_result="${GREEN}✓${NORMAL}"
	if [[ "${actual}" != "${expected}" ]]
	then
		test_result="${RED}˟${NORMAL}"
		save_failed_records "${function_name}" "${test_description}" "${actual}" "${expected}"
	fi

	TOTAL_COUNT=$(( ${TOTAL_COUNT} + 1 ))
	echo -e "\t${test_result} ${test_description}"
}
