#! /bin/bash

function test_read_description() {
  local description="Should read and return description"
  local input="Should return 0 if numbers are equal"
  local expected="Should return 0 if numbers are equal"

  local actual=$( read_description <<< "${input}")
  assert_expectation "${actual}" "${expected}" "${description}" "read_description"
}

function test_read_test_function_name() {
  local description="Should read and return test function name"
  local input="test_is_equal"
  local expected="test_is_equal"

  local actual=$( read_test_function_name <<< "${input}")
  assert_expectation "${actual}" "${expected}" "${description}" "read_test_function_name"
}

function test_read_input() {
  local description="Should read and return input"
  local input=`echo -e "greeting\nhello"`
  local expected="hello"

  local actual=$( read_input <<< "${input}")
  assert_expectation "${actual}" "${expected}" "${description}" "read_input"
}

function test_read_expected() {
  local description="Should read and return expected output"
  local input="1"
  local expected="1"

  local actual=$( read_expected <<< "${input}")
  assert_expectation "${actual}" "${expected}" "${description}" "read_expected"
}

function test_read_callee_function_name() {
  local description="Should read and return caller function name"
  local input="is_equal"
  local expected="is_equal"

  local actual=$( read_callee_function_name <<< "${input}")
  assert_expectation "${actual}" "${expected}" "${description}" "read_caller_function_name"
}

function test_generate_test_function() {
  local template="`cat tests/template`"
  local description="Should generate function using given values"
  local input=$( echo -e "test_is_equal\nShould return 0 if numbers are equal\ndata\n1 2\n0\nis_equal" )
  local expected=$( cat tests/expected_function.txt )

  local actual=$( generate_test_function "${template}" <<< "${input}")
  assert_expectation "${actual}" "${expected}" "${description}" "generate_test_function"
}