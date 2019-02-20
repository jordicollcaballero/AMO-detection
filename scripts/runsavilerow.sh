#!/bin/bash
if [ $# -eq 0 ]; then
	echo -e "usage: $0 [optional args] -x model instance_set_path output_path [extra_arguments]" 
	echo -e "Optional arguments:"
	echo -e "-to <INT>\t : timeout in seconds. Default 600"
	echo -e "-cores <INT>\t : number of cores that a job occupies. It can be either 1, 2 or 4. The maximum memory usage will be set to 1,9G, 3.8G and 7.8G respectively. Default 1 cores and 1.9G"
	echo -e "-p <INT>\t : priority of the jobs. Default -5." 	
	exit
fi
 
ARGS="$@"
NCORES=1
MAXMEM="7.9G"
TIMEOUT=600
PRIORITY="-5"
EXCL="true"
TIME="true"
DEFTMP="false"
SAT="false"
UNSATMIN="false"
UNSATMAX="false"


while [ "$1" != "-x" ]; do
	if [ "$1" == "-to" ]; then
		TIMEOUT=$2
		shift 1
	elif [ "$1" == "-cores" ]; then
		NCORES=$2
		if [ "$2" == "1" ]; then MAXMEM="1.9G"
		elif [ "$2" == "2" ]; then MAXMEM="3.8G"
		elif [ "$2" == "4" ]; then MAXMEM="7.8G"
		else 
			echo "Wrong number of cores per activity. Expected 1, 2 or 4."
			exit
		fi
		shift 1
	elif [ "$1" == "-p" ]; then
		PRIORITY=$2
		shift 1
	else
		echo "Wrong argument $1"
		exit
	fi
	shift 1
done 

shift 1

MODEL=$1
INSTANCES_PATH=${2%/}
OUTPUT_PATH=$3
OUTPUT_DIR=`basename $OUTPUT_PATH`

if [ -d "$OUTPUT_PATH" ]; then
	echo "Directory '${OUTPUT_PATH}' already exists. Jobs not submitted."
	exit
fi

mkdir -p $OUTPUT_PATH

echo "$ARGS" > $OUTPUT_PATH/setting.txt

shift 3

#Submit the jobs
echo "to:${TIMEOUT}" >>  $OUTPUT_PATH/setting.txt
for INSTANCE_PATH in $INSTANCES_PATH/*.param; do
	SHORTNAME=`printf "$INSTANCE_PATH" | rev | cut -d '/' -f 1 | rev`
	OFILE="${OUTPUT_PATH}/${SHORTNAME}"
	JOB="savilerow $MODEL $INSTANCE_PATH -out-solution ${OFILE}.solution -out-sat ${OFILE}.dimacs -out-info ${OFILE}.info -out-minion ${OFILE}.minion $@"
	JOBID=`echo $JOB | qsub -hard  -terse -S /bin/bash -N "_$SHORTNAME" -l excl=true -V -cwd -o $OFILE.out -e $OFILE.err -l h_rt=00:00:${TIMEOUT}  -l h_vmem=$MAXMEM -p $PRIORITY`
done

