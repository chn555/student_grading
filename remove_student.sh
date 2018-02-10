remove_student ()
{
read -p "Enter student ID : " sid
rm students/$sid.student
}


remove_student
