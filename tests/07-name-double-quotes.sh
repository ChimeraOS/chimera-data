if git grep "\- name:" gamedb.yaml | cut -d' ' -f3- | grep -v "^\""; then
	echo "ERROR: All 'name' field values must be quoted with double quotes"
	exit 1
fi

if git grep "\- name:" gamedb.yaml | cut -d' ' -f3- | grep -v "\"$"; then
	echo "ERROR: All 'name' field values must be quoted with double quotes"
	exit 1
fi
