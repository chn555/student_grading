#!/bin/bash
# used to add Students
add_student ()
{
read -p "Enter student ID : " id
read -p "Enter student name : " name
# creates an array with student name and in
sarr=($id $name)
# saves the array to a file, named after the student id
echo ${sarr[*]} >> students.txt
}


# opens the file into an array. adds the grade as the last element of the array
add_grade()
{
read -p "Enter student ID : " id
# opens the file into an array called sarr
# read -a sarr < $id
newarray=$(cat students.txt |grep ^$id)

# printts the array
echo ${newarray[*]}
read -p "Enter grade to be added : " grade
# adds the var grade to the new array called megaarray
megaarray=($newarray $grade)
echo ${megaarray[*]}
# takes the line of newarray and switch with megaarray
#sed "s/$newarray/$megaarray/" students.txt
}


# deletes the student file
remove_student ()
{
read -p "Enter student ID : " id
sed "/$id*/d" students.txt
}

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

student_mavg ()
{
read -p "Enter student ID : " id
read -a sarr < $id
max=0
for v in ${a[@]} ; do
    if (( $v > $max ));
      then max=$v; fi
done
echo $max
}
add_student
add_grade
