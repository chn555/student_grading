student_avg ()
{
  # opens the file into an array called sarr
  # read -a sarr < $id
  read -a  sarr < "$opt"

maxcount=${#sarr[*]}
elenumber=$( expr $maxcount - 2 )
declare -x avg=0
  if [[ $maxcount -le 2 ]]
  then
    continue
  elif [[ $maxcount -eq 2 ]]
  then
    avg=${sarr[2]}
  else
    #  for i in $(eval echo {2..$( expr $maxcount - 1 )}); do
    for i in ${sarr[@]:2} ;do
      sum=$(expr $sum + $i)
    done
    TurboAnalIsisAVG=$(expr $sum / $elenumber )
  fi

  echo "The avarage of student ${sarr[1]} is $TurboAnalIsisAVG points"

}

student_avg
