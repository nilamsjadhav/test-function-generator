#! /bin/bash

function read_test_function_name() {
  local test_function_name
  read -p "Test function name : " test_function_name
  echo ${test_function_name}
}

function read_description() {
  local description
  read -p "Description : " description
  echo ${description}
}

function read_input() {
  local names
  read -p "Names of input : " names
  
  local value inputs=()
  for index in `echo -e "${names}"`
  do
    read -p "${index} : " value
    inputs+=( ${value} )
  done
  echo "${inputs[*]}"
}

function read_expected() {
  local expected  
  read -p "Expected : " expected
  echo ${expected}
}

function read_callee_function_name() {
  local callee_function_name  
  read -p "Callee function name : " callee_function_name
  echo ${callee_function_name}
}

function generate_test_function() {
  local template=$1

  local test_function_name=`read_test_function_name` 
  local description=`read_description`
  local input=`read_input`
  local expected=`read_expected`
  local callee_function_name=`read_callee_function_name`

  sed "s:__TEST_FUNCTION_NAME__:${test_function_name}:g
      s:__INPUT__:${input}:g
      s:__DESCRIPTION__:${description}:g
      s:__EXPECTED__:${expected}:g
      s:__CALLEE_FUNCTION_NAME__:${callee_function_name}:g" <<< "${template}"
}

template=`cat data/template`
test_case=`cat data/test_case_template | grep -v "^#" | grep -v "^$"`
generate_test_function "${template}" <<< "${test_case}"