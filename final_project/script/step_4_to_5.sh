for (( i=0; i<$3; i++ ))
do
	startIndex=$(( 10000*($2+$i)+1 ))
	endIndex=$(( $startIndex+9999 ))
	fileName=chr$1_${startIndex}to${endIndex}.phy
	output=chr$1_block$(( $2+$i ))
	summary=chr$1.tre

	#bash step3.sh $1 $startIndex 10000
	python script/step3.py $1 $startIndex 10000
	raxmlHPC-PTHREADS-SSE3 -s $fileName -n $output -m GTRCAT --HKY85 -F -T 2 -p 12345

	cat RAxML_result.$output >> $summary

	#Remove files we don't want
	rm $fileName
	rm $fileName.reduced
	rm RAxML_info.$output
	rm RAxML_log.$output
	rm RAxML_parsimonyTree.$output
	rm RAxML_result.$output
done
