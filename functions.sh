#!/bin/bash

add_student ()
{
read -p "Enter student ID : " id
read -p "Enter student name : " name

sarr=($name $id)
echo ${sarr[*]} > $id

}

add_grade()
{
read -p "Enter student ID : " id
readarray sarr < $id
echo ${sarr[*]}
read -p "Enter grade to be added : " grade
sarr+=$grade
echo ${sarr[*]} > $id
}
