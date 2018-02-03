remove_student ()
{
read -p "Enter student ID : " id
sed "/$id*/d" students.txt
}


remove_student
