student_avg ()
{
  # opens the file into an array called sarr
  # read -a sarr < $id
  read -a  sarr < "$opt"

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

  echo "The avarage of student ${sarr[1]} is $TurboAnalIsisAVG points."

}

menu()
{
# files lists all student files in the folder
  files=(students/*.student)

  declare -a names

# adds all student file names to array
  for f in $files; do
    names+=$f
  done

echo Select student
    select opt in "${names[@]}" "Stop the script"; do
    case $opt in
      *.student)
        echo "Student file $opt selected"
        #sid=$opt
        #echo $opt
        student_avg
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


menu
