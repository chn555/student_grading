add_grade()
{


# inputs the file to the array
read -a sarr < "students/$opt"

# printts the array
# echo ${sarr[*]}
read -p "Enter grade to be added : " grade
if [[ $grade =~ [0-9]{1,3} ]]; then

  sarr+=("$grade")
  echo ${sarr[*]} > "students/$opt"
  echo "Grade $grade added "
else
  echo Grade is invalid, exiting and Fuck-a-you
fi

}

Sub_Menu_Add_Grade ()
{
# files lists all student files in the folder
files=($(ls students))
echo ${files[*]}
declare -a names

echo Select student
    select opt in "${files[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "Student file $opt selected"
        add_grade
        break
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

Sub_Menu_Add_Grade
