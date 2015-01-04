#!/bin/sh

# vars
HOSTNAME=$(hostname)
MODE="cluster"
JAR="lib/throttle-core-0.0.1.jar"

# parse the options
OPTS=`getopt -a -l client,jar: -- "$0" "$@"`
if [ $? != 0 ]
then
  	exit 1
fi

# replace and eval the args
eval set -- "$OPTS"
while true; do
	case "$1" in 
    	--client) MODE="clientx"; shift;;
    	--jar) JAR=$2; shift; shift;; 
    	--) shift; break;;
  	esac
done

# execute the command
$SPARK_HOME/bin/spark-submit --class akka.Main --master yarn-$MODE $JAR com.snl.services.throttle.Main
