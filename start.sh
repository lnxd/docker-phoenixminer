term_handler() {
	kill -SIGTERM "$killpid"
	wait "$killpid" -f 2>/dev/null
	exit 143;
}

trap 'kill ${!}; term_handler' SIGTERM
./home/docker/mine.sh &
killpid="$!"
while true
do
	wait $killpid
	exit 0;
done