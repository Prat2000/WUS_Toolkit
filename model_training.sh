#!/bin/sh

filename='labels.txt'
n=1

while read line;do
case $n in
	1)model_dir=$line
		;;
	2)training_dir=$line
		;;
	3)dataset_link=$line
		;;
	4)dataset_name=$line
		;;
	5)pretrained_model_link=$line
		;;
	6)pretrained_model_name=$line
esac
n=$((n+1))
done < $filename


echo $model_dir
echo $training_dir
echo $dataset_link
echo $dataset_name
echo $pretrained_model_link
echo $pretrained_model_name

change_dir(){
	cd $1 
}

root_dir=$(pwd)
echo "root_directory=$root_dir"


command= change_dir $root_dir
echo "$command"

command=$(pwd)
echo "$command"


command= change_dir $model_dir
echo "$command"


echo "\e[1;31m AT this STAGE its better to modify the pipeline.config located in $training_dir than coming back again...\e[0m"
echo "\e[1;31m ONCE ready press ANY KEY to continue...\e[0m"
read temp

command= change_dir "models/research/"
echo "$command"

command=$(python3 object_detection/model_main_tf2.py --model_dir=$training_dir --pipeline_config_path=$training_dir/pipeline.config) 
echo "$command"
