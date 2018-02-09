menu ()
{



}





Folder_Creation ()
{
if [[ -d students ]]; then
  :
else
  mkdir students
fi

add_student ()
{

  read -p "Enter student ID : " id

  #TODO add validation for id, name and duplicates

  until [[ $id =~ ^[0-9]{3}$ ]] ;do
    read -p "Invalid ID number, please try again : " id
  done

  read -p "Enter student name : " name

  until [[ $name =~ ^[a-Z]{,9}$ ]] ;do
    read -p "Name is too long or containes invalid characters or spaces, please try again : " name
  done
    # creates an array with student name and in
    sarr=($id $name)
    # saves the array to a file, named after the student id
    echo ${sarr[*]} > students/$id.student
    echo "Student $name created"
}



Sub_Add_Grade_Menu()
{

  files=(students/*.student)
  declare -a names

  for f in $files; do
    names+=$f
  done

echo Select student
    select opt in "${names[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "Student file $opt selected"
        add_grade
        break
        # processing
        ;;
      "Stop the script")
        echo "You chose to stop"
        break
        ;;
      *)
        echo "This is not a valid option"
        ;;
    esac
  done


}



add_grade()
{

#read -p "Enter student ID : " id
# opens the file into an array called sarr
# read -a sarr < $id
read -a  sarr < "$opt"

# printts the array
echo ${sarr[*]}
read -p "Enter grade to be added : " grade
if [[ $grade =~ [0-9]{1,3} ]]; then

  sarr+=("$grade")
  echo ${sarr[*]} > $opt
  echo "Grade $grade added "
else
  echo Grade is invalid, exiting
fi


echo ${#sarr[*]}
echo ${sarr[*]}


student_avg ()
{
  read -p "Enter student ID : " id
  # opens the file into an array called sarr
  # read -a sarr < $id
  read -a  sarr < students/$id.student

  maxcount=${#sarr[*]}
  elenumber=$( expr $maxcount - 2 )
  declare -x avg=0
    if [[ $maxcount -le 1 ]]
    then
      continue
    elif [[ $maxcount -eq 2 ]]
    then
      avg=${sarr[2]}
    else
      #  for i in $(eval echo {2..$( expr $maxcount - 1 )}); do
      for i in ${sarr[@]:2} ;do
        sum=$(expr $sum + $i)
      done
      TurboAnalIsisAVG=$(expr $sum / $elenumber )
    fi

    echo "The best student was ${sarr[1]} with $TurboAnalIsisAVG points avarage"

}


student_avg


student_mavg ()
{

files="/students*.student"
mavrg=0
mavrgstudent="no one"

for f in $files; do
  read -a sarr < $f
  maxcount=${#sarr[*]}

  tmpmavg=0
  if [[ $maxcount -le 1 ]]
  then
    continue
  elif [[ $maxcount -eq 2 ]]
  then
    tmpmavg=${sarr[2]}
    if [[ $tmpmavg -gt $mavrg ]]
    then
      mavrg=$tmpmavg
      mavrgstudent=$f
    else
      continue
    fi
  else
    for i in ${sarr[@]:2} ;do
      tmpsum=$(expr $tmpsum + $i)
    done
    tmpmavg=$(expr $tmpsum / $(expr $maxcount - 2))
    if [[ $tmpmavg -gt $mavrg ]]
    then
      mavrg=$tmpmavg
      mavrgstudent=$f
    else
      continue
    fi
  fi
done

echo "The best student was ${sarr[1]} with $mavrg points avarage"

}


remove_student ()
{
read -p "Enter student ID : " id
rm students/$id.student
}


student_mavg
