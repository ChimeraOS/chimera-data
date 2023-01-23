#! /bin/bash

# prevent premature download triggered by Steam
if echo "$@" | grep "d3ddriverquery64.exe" > /dev/null; then
	exit
fi

TOOL_URL=%TOOL_URL%
TOOL_MD5SUM=%TOOL_MD5SUM%
TOOL_CMD=%TOOL_CMD%

TOOL_FILE="$(basename $TOOL_URL)"
TOOL_DIR=$(echo $TOOL_FILE | sed s/.tar.gz//)
TOOLS_DIR="$HOME/.steam/root/compatibilitytools.d"

PROGRESS_PIPE=$(mktemp chimera-XXXXXX)

pushd "$TOOLS_DIR"
rm -f "$TOOL_FILE"
curl -L -O $TOOL_URL -# 2>&1 | \
  stdbuf -oL tr '\r' '\n' | \
  grep --color=auto --line-buffered -oP '[0-9]*+(?=.[0-9])' > $"PROGRESS_PIPE" &
curl_pid=$?

splash_pid=0
if [ -e /usr/bin/chimera-splash ] ; then
	/usr/bin/chimera-splash --tool "$TOOL_DIR" --pipe-file "$PROGRESS_PIPE" &
	splash_pid=$?
fi

wait $curl_pid

test $splash_pid || kill -9 $splash_pid

if ! echo "$TOOL_MD5SUM $TOOL_FILE" | md5sum --status -c; then
	echo "checksum mismatch"
	exit
fi

rm -rf "$TOOL_DIR"
tar xf "$TOOL_FILE"
rm "$TOOL_FILE"
popd

exec "$TOOLS_DIR/$TOOL_DIR/$TOOL_CMD" $@
