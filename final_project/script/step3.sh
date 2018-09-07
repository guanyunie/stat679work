position=1
while read -r line ; do
	if [ $position -le $(( $2 - ${#line} )) ] ; then
		(( position += ${#line} ))
	elif [ $(( position + ${#string} )) -lt $(( $2+$3 )) ] ; then
		string=$string$line
	else
		break
	fi
done < <(tail -n +2  data/At/TAIR10_chr$1.fas)

reference=${string:$(( $2-$position )):$3}
output="chr$1_$2to$(($2+$3-1)).phy"

file_count=0
for QVfile in data/QV/*.txt
do
	(( file_count += 1 ))	
done 
printf "%s " $file_count >> $output
printf "%s\n" ${#reference} >> $output

for QVfile in data/QV/*.txt
do
	sequence=$reference
	patient=$(basename -s .txt $QVfile | ggrep -Po "quality_variant_\K[^.]+")
	referFile=data/QV_S/${patient}_chr$1.txt
	if [ ! -f $referFile ] ; then 
		continue
	fi
	while read -r line ; do
	    IFS="	"; Array=($line) 
	    if [ ${Array[2]} -lt $2 ] ; then
	    	continue
	    elif [ ${Array[2]} -lt $(( $2+$3 )) ] ; then
	    	index=$(( ${Array[2]} - $2 ))
	    	sequence=${sequence:0:$index}${Array[4]}${reference:$(($index+1))}
	    else
	    	break
	    fi
	done < $referFile
	printf "%s " $patient >> $output
	printf "%s\n" $sequence >> $output
done 


 
