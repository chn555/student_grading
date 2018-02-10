remove_student ()
{

files=($(ls students))
echo ${files[*]}
select opt in "${files[@]}" "Stop the script"; do
	case $opt in
		*.student)
		  	echo "Student will be removed shortly"
			echo $opt
			rm students/$opt
			break
			;;
		"Stop the script")
			echo "You chose to exit"
			break
			;;
		*)
			echo "This is invalid"
			;;
		esac
	done
}


remove_student
