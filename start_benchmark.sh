#!/bin/bash
#Collecting arguments
key1="$1"
key2="$3"
benchmarking_results_dir="$4"
num_files="$2"
#Prepare the environment before running the test
#
if [ ! -d $4 ]; then
  mkdir -p $4/std_output_error
fi
#
echo "Number of file passed for each test is: $num_files"
echo "Your benchmarking started in the background, if you used -email option you will get the periodic status updates"
if [ "$key1" == "-files" ] && [ "$key2" == "-output" ]; then
	if [ "$num_files" -gt 0 ] && [ "$num_files" -lt 2000 ]; then
        	for file_size in 10 50 128 256 512 1024 2048 3072 4096 5120 10240
            		do
                		bash testdfsio.sh $num_files $file_size $benchmarking_results_dir
				if [ "$6" ]; then 
					echo "Benchmarking test run completed for $file_size MB, check the $benchmarking_results_dir directory for more details "| mail -s "Benchmarking status update" $6
				fi
            		done
    	else
    		echo "Num of files is not in the range 1 to 2000"
    	fi
else
    echo "==>Syntax error: Run this script like the following example  <=="
    echo "nohup bash /home/hdfs/scripts/start_benchmark.sh -files 10 -output /home/hdfs/benchmarking_results -email example@gmail.com > start_benchmark.log 2>&1 &"
fi
echo "Benchmark completed for all the tests.  Exiting now"
exit 0 > /dev/null 2>&1
