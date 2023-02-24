---------------------------HDFS-------------------------------------------
hdfs dfs -ls /
hdfs dfs -ls -R /user
hdfs dfs -mkdir /user/cloudera/toberemoved
hdfs dfs -rmdir /user/cloudera/toberemoved

hdfs dfs -ls -R /user/cloudera/output/ 
hdfs dfs -rm -r /user/cloudera/output/*
=============================================================================
hdfs dfs -mkdir /user/cloudera/input
hdfs dfs -mkdir -p /user/cloudera/input
vi sample_input.txt
Press i 
Paste the text you want as : 
What do you mean by Object
What do you know about Java
What is Java Virtual Machine
How Java enabled High Performance
Press Esc then :wq! then Enter
=============================================================================

Make sure that the file created by using the command : cat sample_input.txt
------------------------------------------------------------------------------
hdfs dfs -put sample_input.txt /user/cloudera/input

Make sure that the file loaded and stored into HDFS : 
---------------------------------------------------------
hdfs dfs -ls /user/cloudera/input/

hdfs dfs -cat /user/cloudera/input/sample_input.txt

=============================================================================
hdfs fsck /user/cloudera/input -files -blocks -locations
	blk_1073742232_1410

su root
cloudera
find / -name blk_1073742232* -print

/var/lib/hadoop-hdfs/cache/hdfs/dfs/data/current/BP-286282631-127.0.0.1-1433865208026/current/finalized/subdir0/subdir1/blk_1073742232_1410.meta

ls -ltr /var/lib/hadoop-hdfs/cache/hdfs/dfs/data/current/BP-286282631-127.0.0.1-1433865208026/current/finalized/subdir0/subdir1/blk_1073742232*

cat /var/lib/hadoop-hdfs/cache/hdfs/dfs/data/current/BP-286282631-127.0.0.1-1433865208026/current/finalized/subdir0/subdir1/blk_1073742232

==================================================================
cat /etc/hadoop/conf/hdfs-site.xml

*check property dfs.namenode.checkpoint.dir
*parent directory is : /var/lib/hadoop-hdfs/cache/${user.name}/dfs/namesecondary

cd /var/lib/hadoop-hdfs/cache/
cd hdfs
cd dfs
cd namesecondary
cd current

ls -lhtr /var/lib/hadoop-hdfs/cache/hdfs/dfs/namesecondary/current

---------------------------Map Reduce-------------------------------------------

mkdir /home/cloudera/word_count_job

export LIB_PATH=/usr/lib/hadoop
export JARS=$LIB_PATH/client-0.20/hadoop-core.jar:$LIB_PATH/lib/commons-cli-1.2.jar:$LIB_PATH/client/hadoop-common.jar:$LIB_PATH/hadoop-annotations-2.6.0-cdh5.4.2.jar

javac -classpath $JARS wordcount_classes/WordCount.java

jar -cvf wordcount.jar -C wordcount_classes/ .

hadoop jar wordcount.jar WordCount /user/cloudera/input /user/cloudera/output