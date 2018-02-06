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
  for i in {2..$maxcount}; do
    tmpmavg=$(expr $tmpmavg + ${sarr[$i]})
    if [[ $tmpmavg -gt $mavrg ]]
    then
      mavrg=$tmpmavg
      mavrgstudent=$f
    else
      continue
    fi
  done
done

echo "The best student was $mavrgstudent with $mavrg points avarage"

}


student_mavg
