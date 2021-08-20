#!/bin/sh

echo "\e[1;31m Before starting Please check whether the contents of labels_evaluation.txt are correctly modified in the below order, please use a different shell for doing this
	1. <model dir Name>
	2. <training dir Name>
	\e[0m"
echo  "\e[1;31m ONCE ready Press Any Key to continue ....... \e[0m"
read temp

filename='labels_evaluation.txt'
n=1

while read line;do
case $n in
	1)model_dir=$line
		;;
	2)training_dir=$line
		;;
esac
n=$((n+1))
done < $filename


echo $model_dir
echo $training_dir

change_dir(){
        cd $1
}

command=$(pip3 install tensorflow==2.4.1 tensorflow-object-detection-api pillow matplotlib)
echo "$command" 

command=$(cp $model_dir/research/object_detection/packages/tf2/setup.py $model_dir/research)
echo "$command"

command= change_dir $model_dir/research
echo "$command"

command=$(pip3 install .)
echo "$command"

command=$(pip3 install --upgrade tf_slim)
echo "$command"

command=$(python3 $model_dir/research/object_detection/model_main_tf2.py --model_dir=$training_dir --pipeline_config_path=$training_dir/pipeline.config --checkpoint_dir=$training_dir)
echo "$command"
