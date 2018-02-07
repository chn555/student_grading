student_mavg ()
{

files=*.student
mavrg=0
mavrgstudent="no one"

for f in $files; do
  read -a   sarr < $f
  maxcount=${#sarr[*]}
  echo $maxcount
  tmpmavg=0
  if [[ $maxcount -le 1 ]]
  then
    continue
  elif [[ $maxcount -eq 2 ]]
  then
    tmpmavg=${sarr[2]}
    if [[ $tmpmavg -gt $mavrg ]]
    then
      mavrg=$tmpmavg
      mavrgstudent=$f
    else
      continue
    fi
  else
    for i in $(eval echo {2..$( expr $maxcount - 1 )}); do
      tmpmavg=$(expr $tmpmavg + ${sarr[$i]})
    done
    tmpmavg=$(expr $tmpmavg / $(expr $maxcount - 2))
    if [[ $tmpmavg -gt $mavrg ]]
    then
      mavrg=$tmpmavg
      mavrgstudent=$f
    else
      continue
    fi
  fi
done

echo "The best student was $mavrgstudent with $mavrg points avarage"

}


student_mavg
