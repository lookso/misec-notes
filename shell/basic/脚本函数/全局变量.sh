#!/bin/bash

# using a global variable to pass a value

function db1 {
	value=$[ $value * 2 ]
	local num=123
}
echo $num
read -p "Enter a value: " value
db1
echo "The new value is : $value"

function test() {
    d_i_f="defined in function"
    d_o_f="modified in function"
}
test
echo "---out function---"
echo "d_i_f:" $d_i_f
echo "d_o_f:" $d_o_f