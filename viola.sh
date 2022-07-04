#!/bin/bash

# To run this script, do
# qsub -t 1-324 getConsensusCalls.sh  getConsensusCalls.py <params_consensus_calls>
#
#
#$ -N consensusSV
#$ -R y
#$ -S /bin/bash
#$ -cwd
#$ -l h_vmem=8G
#$ -l h_rt=09:00:00

unset MODULEPATH
. /etc/profile.d/modules.sh

module load anaconda

IDS=$1

manta=`head -n $SGE_TASK_ID $IDS | tail -n 1 | awk '{ print $1 }'`
lumpy=`head -n $SGE_TASK_ID $IDS | tail -n 1 | awk '{ print $2 }'`
delly=`head -n $SGE_TASK_ID $IDS | tail -n 1 | awk '{ print $3 }'`
sample=`head -n $SGE_TASK_ID $IDS | tail -n 1 | awk '{ print $4 }'`

source activate viola-sv
which python

#echo "Call test script without args!"
#python ./test.py


echo "Call script with args!"
python -u ./getConsensusCalls.py $manta $lumpy $delly $sample

#echo "Call consensus script without args!"
#python ./getConsensusCalls.py

#echo "Call consensus script with args!"
#python ./getConsensusCalls.py $manta $lumpy $delly $sample

source deactivate
