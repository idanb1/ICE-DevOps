for i in {1..254}; do IP=172.31.44.$i; if ping -c1 -w1 $IP >/dev/null 2>&1; then echo "ip $IP is occupied" >&2; fi; done
