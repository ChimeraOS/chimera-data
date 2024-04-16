ACTUAL=$(cat gamedb.yaml | grep platform: | cut -d':' -f 2 | sort | uniq -c | tr -s ' ' | cut -d' ' -f 3 | tr '\n' ' ' | sed 's/ $//')
EXPECTED="epic-store flathub gog steam"

if [ "$ACTUAL" != "$EXPECTED" ]; then
	echo "One or more invalid platforms detected."
	echo
	echo "Expected: '$EXPECTED'"
	echo "Actual:   '$ACTUAL'"
	exit 1
fi
