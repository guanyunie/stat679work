# make a new directory to store our seperated data
mkdir data/QV_S
# Seperate each file in quality variant files by chromosome
for QVfile in data/QV/*.txt
do
	patient=$(basename -s .txt $QVfile | ggrep -Po "quality_variant_\K[^.]+")
	while read -r line ; do
		IFS="	"; Array=($line)
		printf "$line\n" >> data/QV_S/${patient}_${Array[1]}.txt
	done < $QVfile
	echo $patient
done
