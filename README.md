# HDFS Benchmarking with TestDFSIO - automating manual steps

Written couple of shell scripts to automate the DFSIO benchmarking.

High level overview:-

    -Run a write testDFSIO job
    -Run a read testDFSIO job
    -clean the HDFS Benchmark Directory
    -repeat all the above steps 5 times.
    
The above tests were iterated 5 times for the following file sizes.
  
 10MB 50MB 128MB 256MB 512MB 1024MB 2048MB 3072MB 4096MB 5120MB 10240MB
 
 Can be customizable in "start_testdfsio.sh"

    ++++++++++++
    How to run:
    ++++++++++++ 
    nohup bash /home/hdfs/scripts/start_benchmark.sh -files 10 -output /home/hdfs/benchmarking_results -email   example@gmail.com > start_benchmark.log 2>&1 &

Inputs:-

    -files   --> No. of HDFS files used for testing the throughput.  

    -output  --> Directory where you want to collect all your benchmarking results.  The script checks and creates the complete path of the directory if it doesn't exist.

    -email   --> your email id

The script should email the status when each iteration (filesize) is completed.

+++++++++++++
Sample email:
+++++++++++++

    "  Benchmarking test run completed for 50 MB, check the /home/hdfs/benchmarking_results directory for more details "


++++++++++++++++++++++
Benchmarking Results:-
++++++++++++++++++++++

        [hdfs@hbase1 benchmarking_results]$ ll
        total 36
        -rw-r--r--. 1 hdfs hadoop 1491 Jun 27 06:20 Read_test_10_files_10_MB
        -rw-r--r--. 1 hdfs hadoop 1493 Jun 27 06:31 Read_test_10_files_128_MB
        -rw-r--r--. 1 hdfs hadoop  300 Jun 27 06:33 Read_test_10_files_256_MB
        -rw-r--r--. 1 hdfs hadoop 1491 Jun 27 06:25 Read_test_10_files_50_MB
        drwxr-xr-x. 2 hdfs hadoop 4096 Jun 27 06:33 std_output_error
        -rw-r--r--. 1 hdfs hadoop 1501 Jun 27 06:19 Write_test_10_files_10_MB
        -rw-r--r--. 1 hdfs hadoop 1501 Jun 27 06:31 Write_test_10_files_128_MB
        -rw-r--r--. 1 hdfs hadoop  299 Jun 27 06:33 Write_test_10_files_256_MB
        -rw-r--r--. 1 hdfs hadoop 1495 Jun 27 06:25 Write_test_10_files_50_MB


All 5 iteration output for a particular file size is combined in 1 file.  

example output for 50MB file Write test output:

        [hdfs@hbase1 benchmarking_results]$ cat Write_test_10_files_50_MB
        ----- TestDFSIO ----- : write
        Date & time: Wed Jun 27 06:20:47 UTC 2018
        Number of files: 10
        Total MBytes processed: 500.0
        Throughput mb/sec: 28.135726745821845
        Average IO rate mb/sec: 30.133743286132812
        IO rate std deviation: 9.189110638956139
        Test exec time sec: 27.067

        ----- TestDFSIO ----- : write
        Date & time: Wed Jun 27 06:21:50 UTC 2018
        Number of files: 10
        Total MBytes processed: 500.0
        Throughput mb/sec: 32.86878779910597
        Average IO rate mb/sec: 37.29134750366211
        IO rate std deviation: 15.178324163358377
        Test exec time sec: 27.152

        ----- TestDFSIO ----- : write
        Date & time: Wed Jun 27 06:22:54 UTC 2018
        Number of files: 10
        Total MBytes processed: 500.0
        Throughput mb/sec: 33.84552900561836
        Average IO rate mb/sec: 36.33448028564453
        IO rate std deviation: 9.388440906004917
        Test exec time sec: 25.233

        ----- TestDFSIO ----- : write
        Date & time: Wed Jun 27 06:24:00 UTC 2018
        Number of files: 10
        Total MBytes processed: 500.0
        Throughput mb/sec: 34.88940060009769
        Average IO rate mb/sec: 37.85911178588867
        IO rate std deviation: 11.650877762432664
        Test exec time sec: 29.224

        ----- TestDFSIO ----- : write
        Date & time: Wed Jun 27 06:25:05 UTC 2018
        Number of files: 10
        Total MBytes processed: 500.0
        Throughput mb/sec: 30.315891590371674
        Average IO rate mb/sec: 31.3275089263916
        IO rate std deviation: 6.5586690376157515
        Test exec time sec: 26.094
