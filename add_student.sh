add_student ()
{

  if [[ -d students ]]; then
    :
  else
    mkdir students
  fi
  
  read -p "Enter student ID : " sid

  until [[ $sid =~ ^[0-9]{3}$ ]] ;do
    read -p "Invalid ID number, please try again : " sid
  done

  read -p "Enter student name : " name

  until [[ $name =~ ^[a-Z]{,9}$ ]] ;do
    read -p "Name is too long or containes invalid characters: " name
  done
    # creates an array with student name and in
    sarr=($sid $name)
    # saves the array to a file, named after the student id
    echo ${sarr[*]} > students/$sid.student
    echo "Student $name created"

}


add_student
