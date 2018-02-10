student_mavg ()
{

files=students/*.student
mavrg=0
mavrgstudent="no one"

for f in $files; do
  read -a sarr < $f
  maxcount=${#sarr[*]}

  tmpmavg=0
  if [[ $maxcount -le 2 ]]
  then
    continue
  elif [[ $maxcount -eq 3 ]]
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
    for i in ${sarr[@]:2} ;do
      tmpsum=$(expr $tmpsum + $i)
    done
    tmpmavg=$(expr $tmpsum / $(expr $maxcount - 2))
    if [[ $tmpmavg -gt $mavrg ]]
    then
      mavrg=$tmpmavg
      mavrgstudent=$f
    else
      continue
    fi
  fi
done

echo "The best student was ${sarr[1]} with $mavrg points avarage"

}


student_mavg
