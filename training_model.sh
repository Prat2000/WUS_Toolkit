#!/bin/sh

echo "\e[1;31m Before starting Please check whether the contents of labels.txt are correctly modified in the below order, please use a different shell for doing this
	1. <model dir Name>
	2. <EMPTY:DONOT CHANGE THIS>
	3. <Dataset URL>
	4. <Datatset Name>
	5. <Pretrained_model URL>
	6. <Pretrained_model_name>
	\e[0m"
echo  "\e[1;31m ONCE ready Press Any Key to continue ....... \e[0m"
read temp

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

echo "\e[1;31m HERE please modify the contents of $root_dir/$model_dir/workspace/training_demo/annotation/label_img.pbtxt\e[0m"
echo "\e[1;31m ONCE ready press ANY KEY to continue...\e[0m"
read  temp

command= change_dir "workspace/training_demo/annotation"
echo "$command"

command=$(gdown --id  $dataset_link)
echo "$command"

command=$(unzip $dataset_name)
echo "$command"

command=$(wget https://tensorflow-object-detection-api-tutorial.readthedocs.io/en/latest/_downloads/d0e545609c5f7f49f39abc7b6a38cec3/partition_dataset.py)
echo "$command"


command=$(python3 change_extension.py)
echo "$command"

command=$(python3 partition_dataset.py -x -i $dataset_name/ -r 0.2)
echo "$command"

command= change_dir "../"
echo "$command"

command=$(wget https://tensorflow-object-detection-api-tutorial.readthedocs.io/en/latest/_downloads/da4babe668a8afb093cc7776d7e630f3/generate_tfrecord.py)
echo "$command"

command=$(python3 generate_tfrecord.py -x annotation/$dataset_name/test -l annotation/label_img.pbtxt -o annotation/test.record)
echo "$command"

command=$(python3 generate_tfrecord.py -x annotation/$dataset_name/train -l annotation/label_img.pbtxt -o annotation/train.record)
echo "$command"

command= change_dir "../.."
echo "$command"

comamnd=$(mkdir -p workspace/training_demo/pre-trained-models)
echo "$command"

command= change_dir "workspace/training_demo/pre-trained-models"
echo "$command"

command=$(wget $pretrained_model_link)
echo "$command"

command=$(tar -xvf *)
echo "$command"

command=$(cp $pretrained_model_name/pipeline.config ../../my_training/)
echo "$command"

echo "\e[1;31m AT this STAGE its better to modify the pipeline.config located in $training_dir than comming back again...\e[0m"
echo "\e[1;31m ONCE ready press ANY KEY to continue...\e[0m"
read temp

command= change_dir "../../../"
echo "$command"

command= change_dir "models/research/"
echo "$command"

command=$(python3 object_detection/model_main_tf2.py --model_dir=$training_dir --pipeline_config_path=$training_dir/pipeline.config) 
echo "$command"
