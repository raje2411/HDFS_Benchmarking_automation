#!/bin/bash
#Print Usage
if [ "$1" == "-h" -o "$1" == "-help" -o "$1" == "--help" ]; then
  echo $'\nUsage:[./test_dfsio.sh <numberof files> <size in MB> <localpath_to_store_benchmarking_output> ]'
  echo $'\nexample:  Use this only if you want to run a specific file size and no.of files you want to test.'
  echo "./testdfsio.sh 10 100 ~/Benchmark_results"
  echo $'\nExecution process:'
  echo $'\nStep1: This will do write test with given input file (Ex: 10 files each with 100MB in /benchmark/TESTDFSIO HDFS path.'
  echo $'\nStep2: It runs a read test with the created files.'
  echo $'\nStep3: Clean up the benchmarking files in HDFS '
  echo $'\n***Repeats the process 5 times by default***'
exit 0
fi
#
#Prepare the environment before running the test
#Check for map-reduce test jar availability
if [ ! -f /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient-tests.jar ]; then
  echo "File doesn't exist on your cluster : /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient-tests.jar.  Please update the script with correct path "
  echo "Exiting the program"
  exit
fi
if [ ! -d $3 ]; then
  mkdir -p $3/std_output_error
fi
#
#Running the each Benchmarking test 5 times
#
for loop_count in {1..5}
do
#Write Test
	hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient-tests.jar TestDFSIO -D mapreduce.job.queuename=default -D mapred.output.compress=false -D test.build.data=DFSIO -write -nrFiles $1 -size $2 -resFile $3/Write_test_$1_files_$2_MB >> $3/std_output_error/Write_Std_out_err_$1_files_$2_MB   2>&1 
#Read Test
	hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient-tests.jar TestDFSIO -D mapreduce.job.queuename=default -D mapred.output.compress=false -D test.build.data=DFSIO -read -nrFiles $1 -size $2 -resFile $3/Read_test_$1_files_$2_MB >> $3/std_output_error/Read_Std_out_err_$1_files_$2_MB   2>&1 
#Cleanup
	hadoop jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-client-jobclient-tests.jar TestDFSIO -D mapreduce.job.queuename=default -D mapred.output.compress=false -D test.build.data=DFSIO -clean >> $3/std_output_error/Cleanup_Std_out_err_$1_file_$2_MB   2>&1
done
#Exit the bash shell
exit 0 > /dev/null 2>&1
