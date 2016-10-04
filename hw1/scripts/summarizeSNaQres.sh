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
