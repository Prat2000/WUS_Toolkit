#!/bin/sh

echo "\e[1;31m Before starting Please check whether the contents of setup.txt are correctly modified in the below order, please use a different shell for doing this
	1. <model dir Name>
	2. <EMPTY:DONOT CHANGE THIS>
	
	\e[0m"
echo  "\e[1;31m ONCE ready Press Any Key to continue ....... \e[0m"
read temp

filename='setup.txt'
n=1

while read line;do
case $n in
	1)model_dir=$line
		;;
	2)training_dir=$line
	
esac
n=$((n+1))
done < $filename


echo $model_dir
echo $training_dir

change_dir(){
	cd $1 
}


root_dir=$(pwd)
echo "root_directory=$root_dir"

training_dir=$root_dir/$model_dir/workspace/my_training
echo "training_dir=$training_dir"

command= $(mkdir -p $model_dir)
echo "$command"

command= change_dir $model_dir
echo "$command"

echo "Starting NOW"


command=$(pip3 install tensorflow==2.2.0 gdown)
echo "$command"

command=$(python3 -c "import tensorflow as tf;print(tf.reduce_sum(tf.random.normal([1000, 1000])))")
echo "$command"

command=$(pip3 install cython)
echo "$command"

command=$(pip3 install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI)
echo "$command"

command=$(git clone https://github.com/tensorflow/models.git)
echo "$command"

command= change_dir "models/research/"
echo "$command"

command=$(cp object_detection/packages/tf2/setup.py .)
echo "$command"

command=$(protoc -I=./ --python_out=./ ./object_detection/protos/*.proto)
echo "$command"

command=$(protoc object_detection/protos/*.proto --python_out=.)
echo "$command"

command=$(pip3 install .)
echo "$command"

command= change_dir $root_dir
echo "$command"

command=$(pwd)
echo "$command"


command= change_dir $model_dir
echo "$command"

command=$(mkdir -p workspace/training_demo/annotation)
echo "$command"

command=$(mkdir -p workspace/my_training)
echo "$command"

command=$(cp $root_dir/change_extension.py workspace/training_demo/annotation)
echo "$command"

command=$(cp $root_dir/label_img.pbtxt workspace/training_demo/annotation)
echo "$command"

