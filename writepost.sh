#!/usr/bin/env bash

is_date="false"

while getopts "h:n:" opt
do
	case $opt in
		h)
			;;
		n)
			echo "-n was accepted: $OPTARG" 
			ARG_N=$OPTARG
			;;
	esac
done

the_title=${ARG_N// /-}
printf -v the_date '%(%Y-%m-%d)T' -1

file_name="${the_date}-${the_title}"
file=./_posts/${file_name}.md

touch ${file}

printf '%s\n' '---' >> ${file}
printf 'layout: post\ntitle: ' >> ${file} 
printf "${ARG_N}" >> ${file}
printf '\ncategories: [' >> ${file}
printf ']\n%s\n' '---' >> ${file}

nvim ${file}
