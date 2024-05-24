if git grep "name:" gamedb.yaml | grep -v "\- name:"; then
	echo "ERROR: 'name' should be the first field"
	exit 1
fi

if git grep -A 1 "name:" gamedb.yaml | grep -v "name:" | grep -v "\--" | grep -v "platform:"; then
	echo "ERROR: 'platform' should be the second field"
	exit 1
fi

if git grep -A 1 "platform:" gamedb.yaml | grep -v "platform:" | grep -v "\--" | grep -v "id:"; then
	echo "ERROR: 'id' should be the third field"
	exit 1
fi

exit 0
