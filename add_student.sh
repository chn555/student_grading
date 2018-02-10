add_student ()
{

  read -p "Enter student ID : " sid

  #TODO add validation for id, name and duplicates

  until [[ $sid =~ ^[0-9]{3}$ ]] ;do
    read -p "Invalid ID number, please try again : " id
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
