#download the seven sample files
cd data/At
for id in 1 2 3 4 5 C M
do
  wget ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/TAIR10_chr$id.fas
done
rm wget-log

#write the three_smallest_chro into a csv file
three_smallest_chro=`ls -l | sort -n | awk '{ print $5 "\t" $9}'|head -n 3`

#divide the things on screen to parts and get what we actually need.
first=`echo $three_smallest_chro | cut -f2,1 -d " "|awk '{ print $2 " " $1}'|sed -E "s/TAIR10_(chr.).fas/\1/"`
second=`echo $three_smallest_chro | cut -f4,3 -d " "|awk '{ print $2 " " $1}'|sed -E "s/TAIR10_(chr.).fas/\1/"`
third=`echo $three_smallest_chro | cut -f6,5 -d " "|awk '{ print $2 " " $1}'|sed -E "s/TAIR10_(chr.).fas/\1/"`

#write append into the csv file
cd ../../
echo "chrmosome","file size" > result/three_smallest_chro.csv
echo $first | tr " " "," >> result/three_smallest_chro.csv
echo $second | tr " " "," >> result/three_smallest_chro.csv
echo $third | tr " " "," >> result/three_smallest_chro.csv
