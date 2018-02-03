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

add_grade
