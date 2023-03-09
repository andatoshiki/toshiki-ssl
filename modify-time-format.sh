#!/bin/bash

# beginning date
# convert value of month into a 2 digits number
if test "${start_arr[0]}" == "Jan"; then
	start_arr[0]="01"
elif test "${start_arr[0]}" == "Feb"; then
	start_arr[0]="02"
elif test "${start_arr[0]}" == "Mar"; then
	start_arr[0]="03"
elif test "${start_arr[0]}" == "Apr"; then
	start_arr[0]="04"
elif test "${start_arr[0]}" == "May"; then
	start_arr[0]="05"
elif test "${start_arr[0]}" == "Jun"; then
	start_arr[0]="06"
elif test "${start_arr[0]}" == "Jul"; then
	start_arr[0]="07"
elif test "${start_arr[0]}" == "Aug"; then
	start_arr[0]="08"
elif test "${start_arr[0]}" == "Sept"; then
	start_arr[0]="09"
elif test "${start_arr[0]}" == "Oct"; then
	start_arr[0]="10"
elif test "${start_arr[0]}" == "Nov"; then
	start_arr[0]="11"
elif test "${start_arr[0]}" == "Dec"; then
	start_arr[0]="12"
fi

# replenish zer before the tenth digit of date
if test "${start_arr[1]}" == "1"; then
	start_arr[1]="01"
elif test "${start_arr[1]}" == "2"; then
	start_arr[1]="02"
elif test "${start_arr[1]}" == "3"; then
	start_arr[1]="03"
elif test "${start_arr[1]}" == "4"; then
	start_arr[1]="04"
elif test "${start_arr[1]}" == "5"; then
	start_arr[1]="05"
elif test "${start_arr[1]}" == "6"; then
	start_arr[1]="06"
elif test "${start_arr[1]}" == "7"; then
	start_arr[1]="07"
elif test "${start_arr[1]}" == "8"; then
	start_arr[1]="08"
elif test "${start_arr[1]}" == "9"; then
	start_arr[1]="09"
fi
start_UTC="${start_arr[3]} ${start_arr[0]} ${start_arr[1]} ${start_arr[2]}"

# expiration date
# convert value of month into a 2 digits number
if test "${expire_arr}" == "Jan"; then
	expire_arr="01"
elif test "${expire_arr}" == "Feb"; then
	expire_arr="02"
elif test "${expire_arr}" == "Mar"; then
	expire_arr="03"
elif test "${expire_arr}" == "Apr"; then
	expire_arr="04"
elif test "${expire_arr}" == "May"; then
	expire_arr="05"
elif test "${expire_arr}" == "Jun"; then
	expire_arr="06"
elif test "${expire_arr}" == "Jul"; then
	expire_arr="07"
elif test "${expire_arr}" == "Aug"; then
	expire_arr="08"
elif test "${expire_arr}" == "Sept"; then
	expire_arr="09"
elif test "${expire_arr}" == "Oct"; then
	expire_arr="10"
elif test "${expire_arr}" == "Nov"; then
	expire_arr="11"
elif test "${expire_arr}" == "Dec"; then
	expire_arr="12"
fi

# 个位数日期前补零
if test "${expire_arr[1]}" == "1"; then
	expire_arr[1]="01"
elif test "${expire_arr[1]}" == "2"; then
	expire_arr[1]="02"
elif test "${expire_arr[1]}" == "3"; then
	expire_arr[1]="03"
elif test "${expire_arr[1]}" == "4"; then
	expire_arr[1]="04"
elif test "${expire_arr[1]}" == "5"; then
	expire_arr[1]="05"
elif test "${expire_arr[1]}" == "6"; then
	expire_arr[1]="06"
elif test "${expire_arr[1]}" == "7"; then
	expire_arr[1]="07"
elif test "${expire_arr[1]}" == "8"; then
	expire_arr[1]="08"
elif test "${expire_arr[1]}" == "9"; then
	expire_arr[1]="09"
fi
expire_UTC="${expire_arr[3]} ${expire_arr} ${expire_arr[1]} ${expire_arr[2]}"
