#!/bin/bash
export CB_BIN=/opt/couchbase/bin
export PATH=$CB_BIN:$PATH

HOST=$1
BUCKET=$2
PWD=$3

echo '<html>'

# Arguments
echo "host = $HOST <br/>"
echo "bucket = $BUCKET <br/>"
echo "pwd = $PWD <br/>"
echo '<hr/>'

# Check
function check {

   METRIC=$1
   EXPECTED=$2

   VAL=`cbstats $HOST:11210 -b $BUCKET -p $PWD all | grep $METRIC | sed "s/ //g" | cut -d':' -f2`

   COLOR=red
   if [ "$VAL" = "$EXPECTED" ]
   then
      COLOR=green
   fi

   echo "<p> $METRIC : <font color="$COLOR">$VAL</font></p>"
                   
}  



if [ "${HOST}null" = "null" ] || [ "${BUCKET}null" = "null" ] || [ "${PWD}null" = "null" ]
then
   echo "Use: $0 <host> <bucket> <pwd>"
else
	echo '<html>'
	echo '<h1> Configuration Report </h1>'
	
	#Checks: please modify the expected numbers regarding your expectations!
	check ep_exp_pager_stime 0
	check access_scanner_enabled false
	check compaction_exp_mem_threshold 0
	check ep_max_num_writers 8
	check ep_max_num_shards 8
	check ep_max_num_readers 8
fi

echo '</html>'