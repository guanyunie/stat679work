#Instructions
##Files
-Working directory:hw1
-hw1-snaqTimeTests/
  -log/
  -out/
-scrips/
  -normalizeFileNames.sh
  -summaryizeSNaQres.sh
  -undoNormalizeFileNames.sh
-results/
  -summary.csv
-readme.md
##normalizeFileNames.sh
	Exercise 1
	Create a shell script `normalizeFileNames.sh` to change all file names `timetesty_snaq.log` to
	`timetest0y_snaq.log` where "y" is a digit between 1 and 9. Similarly, change `timetesty_snaq.out` to
	`timetest0y_snaq.out`.
	Code:
```shell
for i in {1..9}
do
  	mv hw1-snaqTimeTests/log/timetest${i}_snaq.log hw1-snaqTimeTests/log/timetest0${i}_snaq.log
  	mv hw1-snaqTimeTests/out/timetest${i}_snaq.out hw1-snaqTimeTests/out/timetest0${i}_snaq.out
 done
 ```
## summaryizeSnaQres.sh
 	Exercise 2
	Start a summary of the results from all these analyses. The script produces a table in `csv` format,
	with 1 row per analysis and 3 columns:
	-"analysis": the file name root ("xxx")
	-"h": the maximum number of hybridizations allowed during the analysis: `hmax`
	-"CPUtime": total CPU time, or "Elapsed time".
	Code:
```shell
echo analysis, h, CPUtime > ../result/summary.csv

for file in ../hw1-snaqTimeTests/log/*.log
do
  analysis=`grep rootname $file | cut -f 2 -d ":"`

  outname="${file%.*}.out"
  outname="../hw1-snaqTimeTests/out/${outname##*/}"

  h=`grep hmax $file | head -n 1 | cut -f 2 -d '=' | cut -f1 -d,`

  CPUtime=`grep Elapsed\ time $outname | cut -f 2 -d ":"`
  CPUtime=${CPUtime% seconds*}

  echo $analysis, $h, $CPUtime >> ../result/summary.csv

done
```
##undoNormalizeFileNames.sh
```shell
for i in {1..9}
do
  mv hw1-snaqTimeTests/log/timetest0${i}_snaq.log hw1-snaqTimeTests/log/timetest${i}_snaq.log
  mv hw1-snaqTimeTests/out/timetest0${i}_snaq.out hw1-snaqTimeTests/out/timetest${i}_snaq.out
done
```









