add_grade()
{
read -p "Enter student ID : " id
# opens the file into an array called sarr
# read -a sarr < $id
read -a  sarr < $id.student

# printts the array
echo ${sarr[*]}
read -p "Enter grade to be added : " grade

sarr+=("$grade")
echo ${#sarr[*]}
echo ${sarr[*]}
echo ${sarr[*]} > $id.student

echo "Grade $grade added "
}

add_grade
