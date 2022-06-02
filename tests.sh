#!/bin/bash

# colores
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# contador
tests_passed=0

# funciones
test_output() {
  output=$($1)
  expected=$2
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 → $2 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_spim() {
  output=$(echo $1 | $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: echo $1 | $2 → $3 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_redirect() {
  output=$($1 < $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: $1 < $2 → $3 ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: Esperaba '$expected' pero se obtuvo '$output' ${RED}✗${NC}"
  fi
}
test_output_ml() {
  output=$(echo $1 | $2)
  expected=$3
  if [[ "$output" == "$expected" ]]
  then
    echo -e "[  ${GREEN}OK${NC}  ]: echo $1 | spim -q -f groot.s ${GREEN}✓${NC}"
    tests_passed=$((tests_passed + 1))
  else
    echo -e "[ ${RED}Fail${NC} ]: $1 ${RED}✗${NC}"
  fi
}

# 1 groot
test_output_ml "1" "spim -q -f groot.s" "I am Groot"
test_output_ml "2" "spim -q -f groot.s" "I am Groot
I am Groot"
test_output_ml "3" "spim -q -f groot.s" "I am Groot
I am Groot
I am Groot"
test_output_ml "4" "spim -q -f groot.s" "I am Groot
I am Groot
I am Groot
I am Groot"
test_output_ml "5" "spim -q -f groot.s" "I am Groot
I am Groot
I am Groot
I am Groot
I am Groot"
test_output_ml "6" "spim -q -f groot.s" "I am Groot
I am Groot
I am Groot
I am Groot
I am Groot
I am Groot"
test_output_ml "-1" "spim -q -f groot.s" "Error"
test_output_ml "-10" "spim -q -f groot.s" "Error"
test_output_ml "7" "spim -q -f groot.s" "I am Groot
I am Groot
I am Groot
I am Groot
I am Groot
I am Groot
I am Groot"
test_output_ml "-1234" "spim -q -f groot.s" "Error"
# 2 factorial
test_output "spim -q -f factorial.s 1" "1"
test_output "spim -q -f factorial.s 0" "1"
test_output "spim -q -f factorial.s -1" "Error"
test_output "spim -q -f factorial.s 4" "24"
test_output "spim -q -f factorial.s 5" "120"
test_output "spim -q -f factorial.s 6" "720"
test_output "spim -q -f factorial.s 7" "5040"
test_output "spim -q -f factorial.s -100" "Error"
test_output "spim -q -f factorial.s 9" "362880"
test_output "spim -q -f factorial.s 10" "3628800"

# resultado final
echo "--------------  Resultado  --------------"
if [[ $tests_passed -eq 20 ]]
then
  echo -e "Todos los tests pasaron ${GREEN}✓${NC}"
else
  echo "Resultado: $tests_passed/20 tests OK."
fi

exit 0
