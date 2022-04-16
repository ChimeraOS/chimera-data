result=$(cat gamedb.yaml | grep id: | cut -d':' -f 2 | sort | uniq -cd | tr -s ' ' | cut -d' ' -f 3)

if [ -n "$result" ]; then
	echo "The following game ids have duplicate entries:"
	echo "$result"
	exit 1;
fi
