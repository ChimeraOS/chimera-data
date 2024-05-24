cat gamedb.yaml | grep "name:" | sed 's/- name: //' | sed 's/  name: //' | sed -E 's/^"|"$//g' | sed -E "s/^'|'$//g" | sed 's/^A //I' | sed 's/^An //I' | sed 's/^The //I' > /tmp/chimera_gamedb_original_order
cat /tmp/chimera_gamedb_original_order | sort --ignore-case > /tmp/chimera_gamedb_sorted_order

diff -u /tmp/chimera_gamedb_original_order /tmp/chimera_gamedb_sorted_order
if [ $? != 0 ]; then
	echo "gamedb.yaml should be in alphabetical order by name."
	exit 1
fi
