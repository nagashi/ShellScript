#! /bin/bash
#

# Define the shell functions
#
usage(){
        # shellcheck disable=SC2317
        echo "Usage: $0 [-h]" >&2
        # shellcheck disable=SC2317
        exit 0
}

die()
{
        # shellcheck disable=SC2317
        echo "$1" >&2
        # shellcheck disable=SC2317
        exit 1

}

# Configure the kill actions to take
# shellcheck disable=SC2064
trap "echo $0: killed @ $(date) ; exit 99" SIGHUP SIGINT SIGTERM

#
# cd to /srv/chain directory
#
export BC="tendermint"
#echo $BC

#mask directory
H=$(pwd)/$BC
#echo $H

#if directory doesn't exist, make it.
[ -d "$H" ] || mkdir -p "$H" 2> /dev/null

cd "$H" || { echo "Error----> Cannot change to $H directory." >&2; exit 2; }

touch xx || { echo "Error----> Cannot write to $H directory." >&2; exit 2; }
rm xx || { echo "Error----> Cannot remove file xx in $H directory." >&2; exit 2; }

export NB=4191200
# shellcheck disable=SC2155
# shellcheck disable=SC2012
export NB=$(ls -l 4* | awk  '{print $9;}' | tail -1)
#echo $NB
# shellcheck disable=SC2155
# shellcheck disable=SC2086
export NB="$(echo  $NB | awk '{print $1-1;}')"
#echo $NB
#exit 0

# shellcheck disable=SC2034
for i in 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 \
         0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 \
         0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 \
         0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 \
         0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4
do  
	NB=$(echo "$NB" | awk '{print $1+1;}')
	export NB
	# echo "$NB"
	X=$((4191200 - i))
	# echo "$X"
	# shellcheck disable=SC2086
	curl --connect-timeout 6 --request GET --url https://migaloo-api.polkachu.com/cosmos/base/tendermint/v1beta1/blocks/$X  >$NB 2>/dev/null
	grep '"code": 3' "$NB" >/dev/null 2>/dev/null
	# shellcheck disable=SC2181
	if [  "$?" -eq 0 ]
	then
		exit 0
	fi
	#sleep 1
done

exit 0

# shellcheck disable=SC2317
export BN=4143887
# shellcheck disable=SC2317
echo "curl --request GET --url http://116.202.143.93:1317/cosmos/base/tendermint/v1beta1/blocks/$BN"

# shellcheck disable=SC2317
exit 0