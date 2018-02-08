add_grade()
{

#read -p "Enter student ID : " id
# opens the file into an array called sarr
# read -a sarr < $id
read -a  sarr < "$id"

# printts the array
echo ${sarr[*]}
read -p "Enter grade to be added : " grade

sarr+=("$grade")
echo ${#sarr[*]}
echo ${sarr[*]}
echo ${sarr[*]} > $id

echo "Grade $grade added "
}

menu()
{

  files=(*.student)
  declare -a names

  for f in $files; do
    names+=$f
  done


    select opt in "${names[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "War file $opt selected"
        id=$ops
        echo $ops
        add_grade
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
