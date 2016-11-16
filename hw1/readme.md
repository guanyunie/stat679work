<<<<<<< HEAD
#Instructions
##Exercise 3
###Updated:
- summaryizeSNaQres.sh
- results/summary.csv
###To run the code:
```shell
bash ./hw1/scripts/summaryizeSNaQres.sh
```
###purpose:
To update `summary.csv` to add more information, which are:
 - Nruns: number of runs
 - Nfail: tuning parameter, "max number of failed proposals"
 - fabs: tuning parameter called "ftolAbs" in the log file
 - frel: "ftolRel"
 - xabs: "xtolAbs"
 - xrel: "xtolRel"
 - seed: main seed, i.e. seed for the first runs
 - under3460: number of runs that returned a network with a score (`-loglik` value) better than (below) 3460
 - under3450: number of runs with a network score under 3450
 - under3440: number of runs with a network score under 3440
###Code:
```shell
echo analysis, h, CPUtime, Nruns, Nfail, fabs, frel, xabs, xrel, seed, under3460, under3450, under3440 > ../result/summary.csv

for file in ../hw1-snaqTimeTests/log/*.log
do
  analysis=`grep rootname $file | cut -f 2 -d ":"`

  #outname="${file%.*}.out"
  #outname="../hw1-snaqTimeTests/out/${outname##*/}"

  outname=`basename -s ".log" $file`
  outname="../hw1-snaqTimeTests/out/$outname.out"

  h=`grep hmax $file | head -n 1 | cut -f 2 -d '=' | cut -f1 -d,`

  CPUtime=`grep Elapsed\ time $outname | cut -f 2 -d ":"`
  CPUtime=${CPUtime% seconds*}

  #First find lines having "runs", then extract the number before "runs"
  Nruns=`grep runs $file | sed -E 's/.* ([0-9]+) runs.*/\1/'`
  #First find lines having "max number of failed proposals", then extract the number before ","
  Nfail=`grep 'max number of failed proposals' $file | sed -E 's/.*= ([0-9]+),.*/\1/'`
  #First find lines having "ftolAbs", then extract anything after "ftolAbs=" and before ","
  fabs=`grep ftolAbs $file | sed -E 's/.*ftolAbs=(.*),/\1/'`
  #First find lines having "ftolRel", then extract anything after "tolRel=" and before ", f"
  frel=`grep ftolRel $file | sed -E 's/.*ftolRel=(.*), f.*/\1/'`
  #First find lines having "xtolAbs", then extract anything after "xtolAbs=" and before ","
  xabs=`grep xtolAbs $file | sed -E 's/.*xtolAbs=(.*),.*/\1/'`
  #First find lines having "xtolRel", then extract anything after "xtolRel=" and before"."
  xrel=`grep xtolRel $file | sed -E 's/.*xtolRel=(.*)\..*/\1/'`
  #First find lines having "main seed", then extract numbers after a space
  seed=`grep 'main seed' $file | sed -E 's/.* ([0-9]+)/\1/'`

  #initialize number of runs with a network score under 3460
  i=0
  #initialize number of runs with a network score under 3450
  j=0
  #initialize number of runs with a network score under 3440
  k=0
  #First find lines having "loglik of best", then extract numbers after a space and before a "."
  scores=`grep "loglik of best" $file | sed -E 's/.* ([0-9]+)\..*/\1/'`

  for l in $scores
  do
    if [ $l -lt 3460 ]
    then
      i=$((i+1))
    fi

    if [ $l -lt 3450 ]
    then
      j=$((j+1))
    fi

    if [ $l -lt 3440 ]
    then
      k=$((k+1))
    fi
  done
  
  echo $analysis, $h, $CPUtime, $Nruns, $Nfail, $fabs, $frel, $xabs, $xrel, $seed, $i, $j, $k >> ../result/summary.csv

done
```

##Files
- Working directory:hw1
- hw1-snaqTimeTests/
  - log/
  - out/
- scrips/
  - normalizeFileNames.sh
  - summaryizeSNaQres.sh
  - undoNormalizeFileNames.sh
- results/
  - summary.csv
- readme.md
##normalizeFileNames.sh
	Exercise 1  
	Create a shell script `normalizeFileNames.sh` to change all file names `timetesty_snaq.log` to
	`timetest0y_snaq.log` where "y" is a digit between 1 and 9. Similarly, change `timetesty_snaq.out` to
	`timetest0y_snaq.out`.
	Code:
=======
# Instructions
## Files
- Working directory:hw1
- hw1-snaqTimeTests/
  - log/
  - out/
- scrips/
  - normalizeFileNames.sh
  - summaryizeSNaQres.sh
  - undoNormalizeFileNames.sh
- results/
  - summary.csv
- readme.md
## normalizeFileNames.sh
Exercise 1
Create a shell script `normalizeFileNames.sh` to change all file names `timetesty_snaq.log` to `timetest0y_snaq.log` where "y" is a digit between 1 and 9. Similarly, change `timetesty_snaq.out` to `timetest0y_snaq.out`.  
Code:
>>>>>>> f029249be0fa23e158cc780cc3a9ea9c07be2f51
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
- "analysis": the file name root ("xxx")
- "h": the maximum number of hybridizations allowed during the analysis: `hmax`
- "CPUtime": total CPU time, or "Elapsed time".  
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
## undoNormalizeFileNames.sh
```shell
for i in {1..9}
do
  mv hw1-snaqTimeTests/log/timetest0${i}_snaq.log hw1-snaqTimeTests/log/timetest${i}_snaq.log
  mv hw1-snaqTimeTests/out/timetest0${i}_snaq.out hw1-snaqTimeTests/out/timetest${i}_snaq.out
done
```









