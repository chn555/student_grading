#!/bin/bash



Replace_Student()
{
  read -a FirstArrayOne < "$opt1"
  read -a SecondArrayOne < "$opt2"

  read -a FirstArrayTwo < "$opt1"
  read -a FirstArrayTwo < "$opt2"

  unset SecondArrayOne[@]:2
  for i in ${FirstArrayOne[@]:2}; do
    

}

SubMenu_Replace_Student()

{

  for f in $files; do
    names+=$f
  done

  echo Select 1st student
    select opt1 in "${names[@]}" "Stop the script"; do
      case $opt1 in
        *.student)
            echo "Student $opt1 selected"
            SubMenu_Replace_Student2
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


SubMenu_Replace_Student2()

{

  for f in $files; do
    names+=$f
  done

  echo Select 2nd student
    select opt2 in "${names[@]}" "Stop the script"; do
      case $opt2 in
        *.student)
            echo "Student $opt2 selected"
            Replace_Student
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
