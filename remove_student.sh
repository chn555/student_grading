remove_student ()
{
files=($(ls students))
echo ${files[*]}
declare -a names
read -p "Enter student ID : " sid
rm students/$sid.student
}


remove_student
