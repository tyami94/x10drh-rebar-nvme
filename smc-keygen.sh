#!/usr/bin/env sh

# Supermicro BMC keygen for X10 mainboards

if [ -z "$1" ]; then
	echo "Usage: $0 <BMC MAC Address>" >&2
	echo ""
	echo "Note: both ':' and '-' separators will work, as will no seperator"
	echo ""
	exit 1
fi

bmc_mac="$1"; 


# This is where the magic happens:
#  1. We pipe bmc_mac into xxd to get raw bytes
#  2. Then we use openssl to generate an HMAC of the raw hex bytes using the secret key dumped from the BMC firmware
#  3. Next we pull the key from the openssl output with awk
#  4. Truncate it with cut so only the first 24 bytes remain
#
# Source: https://peterkleissner.com/2018/05/27/reverse-engineering-supermicro-ipmi/

raw_key="$(echo -n "$bmc_mac" | xxd -r -p | openssl dgst -sha1 -mac HMAC -macopt hexkey:8544E3B47ECA58F9583043F8 | awk '{print $2}' | cut -c 1-24)"

# We then take this key and break it up into 4 byte groups so its easier to enter into the web ui

output_key=""

while [ -n "$raw_key" ]; do
	group="${raw_key:0:4}"
	raw_key="${raw_key:4}"
	output_key="${output_key}${group} "
done

echo "${output_key% }"
