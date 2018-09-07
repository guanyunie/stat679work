#The file is to get the most comprehensive data set of “quality_variant” files.
#We get 216 files in step1 before, but after double-checking, we get 224files, 8 files more.
#However, the following steps are using 216 files instead since we checked it after finishing
#almost all the following steps and have already got the result, thus it is an individual
#file and has no relationship with the following steps.
ids=`curl http://signal.salk.edu/atg1001/download.php | grep "Salk" | gsed -E 's/.*id=([^>]+)>.*/\1/' | grep "^[^<]" | grep "^[^f]"`

cd data/QV
for id in $ids
do
  wget http://signal.salk.edu/atg1001/data/Salk/quality_variant_$id.txt
done

ids=`curl http://signal.salk.edu/atg1001/data/Salk/ | grep ".txt" | gsed -E 's/.*txt>(.*).txt<.*/\1/'`
for id in $ids
do
  wget http://signal.salk.edu/atg1001/data/Salk/quality_variant_$id.txt
done

for file in *.txt.1
do
  rm $file
done 
rm wget-log


number=`find . -type f -print|wc -l`
echo $number
three_smallest_chro=`ls -l | awk '{ print $5 "\t" $9}'`

echo "total file","filename","file size" > ../../result/qvfiles.csv
echo $number,"","">> ../../result/qvfiles.csv
for n in $(seq 2 1 217)
do
  file=`ls -l | awk '{ print $5 "\t" $9}'|head -n $n | tail -n 1`
  output=`echo $file|cut -f2,1 -d " "|awk '{ print $2 " " $1}'`
  echo "",$output | tr " " "," >> ../../result/qvfiles.csv
done
