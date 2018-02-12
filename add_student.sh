add_student (){
  if [[ -d students ]]; then
    :
  else
    mkdir students
  fi
  #read -p "Enter student ID : " sid
  sid=$(zenity --entry \
    --title="Add new profile" \
    --text="Enter ID of new student:" \
    --entry-text "NewStudent")
  until [[ $sid =~ ^[0-9]{3}$ ]] ;do
    sid=$(zenity --entry \
    --title="Add new profile" \
    --text="ID invalid, Enter ID of new student:" \
    --entry-text "NewStudent")
    if [[ $sid == "NewStudent" ]]; then
      return
    else
      :
    fi
  done
  #read -p "Enter student name : " name
  name=$(zenity --entry \
    --title="Add new profile" \
    --text="Enter name of new student:" \
    --entry-text "NewStudent")
  until [[ $name =~ ^[a-Z]{,9}$ ]] ;do
    name=$(zenity --entry \
    --title="Add new profile" \
    --text="Name is too long or containes invalid characters, Enter name of new student:" \
    --entry-text "NewStudent")
    if [[ $name == "NewStudent" ]]; then
      return
    else
      :
    fi
  done
  # creates an array with student name and in
  sarr=($sid $name)
  # saves the array to a file, named after the student id
  echo ${sarr[*]} > students/$sid.student
  zenity --info --text="Student $name created successfully" --width 300
}
