#!/bin/bash
# if [ -z "${2}" ]; then
# 	"${1}"/nvim -u "${1}/init.lua"
# else
# 	"${1}"/nvim -u "${1}/init.lua" "${2}"
# fi
if [ -z "${2}" ]; then
	"${1}"/nvim
else
	# nvim由bash启动,因此nvim的环境继承bash的环境
	"${1}"/nvim "${2}"
fi
