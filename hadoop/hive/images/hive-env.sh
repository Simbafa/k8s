#
# if [ "$SERVICE" = "cli" ]; then
#   if [ -z "$DEBUG" ]; then
#     export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms10m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 -XX:+UseParNewGC -XX:-UseGCOverheadLimit"
#   else
#     export HADOOP_OPTS="$HADOOP_OPTS -XX:NewRatio=12 -Xms10m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=15 -XX:-UseGCOverheadLimit"
#   fi
# fi

# Folder containing extra libraries required for hive compilation/execution can be controlled by:
# export HIVE_AUX_JARS_PATH=
export SPARK_DIST_CLASSPATH=$(hadoop classpath)
export HADOOP_CLIENT_OPTS="-Xmx512m -XX:MaxPermSize=1024m $HADOOP_CLIENT_OPTS"
#export HIVE_AUX_JARS_PATH=file:///usr/local/hive/lib/HiveAdmin-1.0.0.jar
