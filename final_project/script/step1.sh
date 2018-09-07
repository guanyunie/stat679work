#get the file name used to download files
ids=`curl http://signal.salk.edu/atg1001/download.php | grep "Salk" | gsed -E 's/.*id=([^>]+)>.*/\1/' | grep "^[^<]" | grep "^[^f]"`

#download each SNP data file
cd data/QV
for id in $ids
do
  wget http://signal.salk.edu/atg1001/data/Salk/quality_variant_$id.txt
done
rm wget-log

#find the target number, file_name and file size
number=`find . -type f -print|wc -l`
echo $number
three_smallest_chro=`ls -l | awk '{ print $5 "\t" $9}'`

#write into a csv file under directory result.
echo "total file","filename","file size" > ../../result/qvfiles.csv
echo $number,"","">> ../../result/qvfiles.csv
for n in $(seq 2 1 217)
do
  file=`ls -l | awk '{ print $5 "\t" $9}'|head -n $n | tail -n 1`
  output=`echo $file|cut -f2,1 -d " "|awk '{ print $2 " " $1}'`
  echo "",$output | tr " " "," >> ../../result/qvfiles.csv
done
cd ../..
