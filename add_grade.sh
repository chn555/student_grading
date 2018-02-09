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



}

menu()
{

  files=(*.student)
  declare -a names

  for f in $files; do
    names+=$f
  done

echo Select student
    select opt in "${names[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "Student file $opt selected"
        id=$ops
        echo $ops
        add_grade
        break
        # processing
        ;;
      "Stop the script")
        echo "You chose to stop"
        break
        ;;
      *)
        echo "This is not a number"
        ;;
    esac
  done


}

menu
