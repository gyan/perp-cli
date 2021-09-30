#!/bin/bash
echo "Bash version ${BASH_VERSION}..."

# 18283570
# 17913570
# 17813570
# 13508290
# run processes and store pids in array
start=17712569
end=13508290
jump=100000


while [ $start -gt $end ]
do
  limit=$[$start - 100000] 
  while [ $start -gt $limit ]
  do
    echo $start
    npx ts-node src/cli/index.ts position --blockNumber $start --blockLimit 10000 --fileName "./output/block_$start.csv" &
    pids[$start]=$!
    start=$[$start - 10000]
  done

  for pid in ${pids[*]}; 
  do
    echo "waiting on process: ${pid}"
    wait $pid
  done

done

# for (( i=$start; i<=$end; i=i+$jump))
# do
  # echo "process at block: ${i}"
  # limit=$i-100000
  # echo $limit
  # for j in {$i..$limit..-10000}
  # do
  #   echo "block stage: ${j}"
  #   npx ts-node src/cli/index.ts position --blockNumber $j --blockLimit 10000 --fileName "./output/block_${j}.csv" &
  #   pids[${j}]=$!
  # done
  # # wait for all pids
  # for pid in ${pids[*]}; 
  # do
  #   echo "waiting on process: ${pid}"
  #   wait $pid
  # done
# done