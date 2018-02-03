student_avg ()
{
read -p "Enter student ID : " id
# opens file into array
newarray=$(cat students.txt |grep ^$id)
# prints all elements after 2. 0 and 1 are name and id
echo ${newarray[@]:2}
${#newarray[*]} = sarrcount
newarraysum=0
for $i in 2..$newarraycount; do
  newarraysum=$( expr ${newarray[$i]} + $newarraysum)
  count= $(expr $count + 1 )
done
avg=$( expr $newarraysum / $count)
echo $avg
}


student_avg
