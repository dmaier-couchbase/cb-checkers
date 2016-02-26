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
	echo "<h1> Configuration Report - $HOSTNAME</h1>"
	
	#Checks: please modify the expected numbers regarding your expectations!
	# Is the expiry pager enabled or disabled?
	check ep_exp_pager_stime 0

	# Is the access log scanner enabled or disabled?
	check access_scanner_enabled false

	# What's the access log scanner path?
        check ep_alog_path /opt/couchbase/var/lib/couchbase/data/graph/access.log	

	# What's the expiration via compaction threshold?
	check compaction_exp_mem_threshold 0

	# What's the number of writer threads?	
	check ep_max_num_writers 8

	# What's the number of partitions the threads are assigned to?
	check ep_max_num_shards 8

	# What's the number or reader threads?
	check ep_max_num_readers 8
fi

echo '</html>'
