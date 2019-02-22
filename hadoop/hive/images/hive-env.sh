#
# if [ "$SERVICE" = "cli" ]; then
#   if [ -z "$DEBUG" ]; then
#     export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms10m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 -XX:+UseParNewGC -XX:-UseGCOverheadLimit"
#   else
#     export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms10m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 -XX:-UseGCOverheadLimit"
#   fi
# fi
export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms1024m -Xmx4096m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 "
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+UseParNewGC"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:ParallelGCThreads=2"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:MaxTenuringThreshold=10"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:TargetSurvivorRatio=70"
export HADOOP_OPTS="$HADOOP_OPTS -XX:-UseGCOverheadLimit"
export HADOOP_OPTS="$HADOOP_OPTS -XX:+UseConcMarkSweepGC"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+CMSConcurrentMTEnabled"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:ParallelCMSThreads=2"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+UseCMSInitiatingOccupancyOnly"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+CMSClassUnloadingEnabled"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+DisableExplicitGC"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:CMSInitiatingOccupancyFraction=70"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+UseCMSCompactAtFullCollection"
export HADOOP_OPTS="$HADOOP_OPTS -XX:CMSFullGCsBeforeCompaction=1"
#export HADOOP_OPTS="$HADOOP_OPTS -verbose:gc"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+PrintGCDetails"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:+PrintGCDateStamps"
#export HADOOP_OPTS="$HADOOP_OPTS -XX:GCLogFileSize=512M"

export HADOOP_OPTS="$HADOOP_OPTS -Dsun.zip.disableMemoryMapping=true"
export HADOOP_CLIENT_OPTS="$HADOOP_CLIENT_OPTS -Dsun.zip.disableMemoryMapping=true"

# Folder containing extra libraries required for hive compilation/execution can be controlled by:
# export HIVE_AUX_JARS_PATH=
export SPARK_DIST_CLASSPATH=$(hadoop classpath)
export HADOOP_HEAPSIZE=4096
#export HIVE_AUX_JARS_PATH=file:///usr/local/hive/lib/HiveAdmin-1.0.0.jar
