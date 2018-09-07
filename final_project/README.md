project1-team5
===================

Directory
----------------

- project1-team5/
  - script/
    - [**step1.sh**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step1.sh):
      Downloading all “quality_variant” files for all strains listed.
    - [**step1_comprehensive.sh**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step1_comprehensive.sh):
      Downloading more comprehensive SNP data files than step1.sh. However, it's not used in following steps.
    - [**step2.sh**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step2.sh):
      Downloading all Arabidopsis thaliana reference genome.
    - [**step_pre_3.sh**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step_pre_3.sh):
      Seperate each quality variant file into 7 files by chromosomes.
    - [**step3.py**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step3.py):
      Python script, which is faster than shell. Returns an alignment of the DNA sequences of all strains for a chromosome of interest and for a genomic range of interest.
    - [**step3.sh**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step3.sh):
      Shell script, the same function as step3.py. Returns an alignment of the DNA sequences of all strains for a chromosome of interest and for a genomic range of interest.
    - [**step_4_to_5.sh**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step_4_to_5.sh):
      Cut a chromosome into non-overlapping alignments of length 10000 base pairs(except for the last one).
    - [**step7.R**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step7.R):
    This step is to test tree similarity. For each of chromosomeC, chromosomeM and chromosome2, our goal is to find:
    (a)The observed tree distances are closer to 0 than expected if the 2 trees were chosen at random uniformly?
    (b)Trees from 2 consecutive blocks tend to be more similar to each other (at smaller distance) than trees from 2 randomly chosen blocks from the same chromosome
  - result/  
    There are two directories, one is called result, the other one is called trees. Both two represent results we got, but different contents.
    - [**report.md**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/report.md):
    Summary of our results.
    - [**qvfiles.csv**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/qvfiles.csv):
    It contains the information of files we got in step1. Three columns exist, one is the total file number, one is filenames for each SNP data file, the last one represents file size.
    - [**three_smallest_chro.csv**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/three_smallest_chro.csv):
      3 smallest chromosomes we analysed and got from step2. They are actually chromosome2, chromosomeC and chromosomeM. The first column represents chromosome name, the second one represents file size.
    - [**step7_plot.pdf**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/step7_plot.pdf):
    It contains six plots made in step7 to analyze and answer question(a) and question(b) in step7.
    - [**readme.md**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/readme.md) under the directory result also explain these.
  - trees/
    - [**chr2.tre**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/trees/chr2.tre):
    Trees got from chromosome2.
    - [**chrC.tre**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/trees/chrC.tre):
    Trees got from chromosomeC.
    - [**chrM.tre**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/trees/chrM.tre):
    Trees got from chromosomeM.
    - [**RAxML_RF-Distances.chr2dist**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/trees/RAxML_RF-Distances.chr2dist):
    distance between trees in chromosome2.
    - [**RAxML_RF-Distances.chrCdist**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/trees/RAxML_RF-Distances.chrCdist):
    distance between trees in chromosomeC.
    - [**RAxML_RF-Distances.chrMdist**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/trees/RAxML_RF-Distances.chrMdist):
    distance between trees in chromosomeM.
  - debug
    - [**filenames.txt**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/debug/filenames.txt):
      Debugging file, all downloaded quality variant files.
    - [**strains.txt**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/debug/strains.txt):
      Debugging file, all quality variant files online.

Notes
----------------

####0.
For detail description, please see the course website:
http://cecileane.github.io/computingtools/pages/project1stepsinstructions

####1.  
When downloading quality_variant files, the following error appeared:

```shell
./script/downloadFile.sh: line 7: 001/data/Salk/quality_variant_Zdr_1.txt: No such file or directory
./script/downloadFile.sh: line 8: syntax error near unexpected token `done'
./script/downloadFile.sh: line 8: `done'
```
debugging procedure:
Save all strains names grep from webpage in one file:
```shell
curl http://signal.salk.edu/atg1001/download.php | grep "Salk" | gsed -E 's/.*id=([^>]+)>.*/\1/' | grep "^[^<]" | grep "^[^f]" > strains.txt
wc strains.txt
```
The result shows there are 217 lines.
Save all downloaded files' names in one file:
```shell
ls data | gsed -E 's/quality_variant_(.*).txt/\1/' > filenames.txt
wc filenames.txt
```
The result shows there are 216 lines.
Compare two files:
```shell
diff strains.txt filenames.txt
```
result:
```shell
130a131
> N13
134d134
< N13
203d202
< Utrecht
```
We don't know why "N13" shows up here, since two "N13"s are the same(and there are no extra spaces). When looking at "Utrecht" files on webpage, it says "Object not found." So we figured out that the file from the source is somehow damaged.

####2.  
In step 3, we first seperate the `quality variant` data by chromosomes. The seperated data files have the file names of `patient_chromosome.txt`, for example, `Aa_0_chr1.txt`. This pre step makes our step 3 much faster when we have to read latter lines of `quality variant` files. However, due to the large size of the data file, we did not upload here. After executing
```shell
bash step_pre_3.sh
```
there will be a new directory named `QV_S` under `data/` and we use data from `QV_S` in step3.

####3.
We didn't use SNP data downloaded directly, instead, we separate quality_variant files by chromosomes. For example, quality_variant_Aa_0.txt file is separated to 7files, Aa_0_chr1.txt, Aa_0_chr2.txt, Aa_0_chr3.txt, Aa_0_chr4.txt, Aa_0_chr5.txt, Aa_0_chrC.txt and Aa_0_chrM.txt.

[step_pre_3.sh](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step_pre_3.sh) will do that step.

####4.
The step 6 is not in the script, in fact we run step 6 directly under the guidance of project instruction.

####5.
Some examples are shown in [report.md](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/report.md)


Usage
-------------
###step1
Get the SNP data:
```shell
bash script/step1.sh
```

###step2
Get the reference genome:
```shell
bash script/step2.sh
```

###step3
Build individual genomes:
First seperate quality variant files by chromosomes:
```shell
bash step_pre_3.sh
#This takes about 6 hours
```
and all the following steps is using the separated files instead of the files obtained from the website.(Hence, we suggest the reader not re-run the scripts unless needed.)

Then build individual genomes of interest(from `startposition` to `startposition+length`):
```shell
python script/step3.py chromosome startposition length
```
Three parameters:
- chromosome (in 1-5, C or M)
- startposition: starting base position (e.g. 1,2,…,20000,…), with indexing starting at 1 because “position” indices start at 1 in the SNP data files
- length: alignment length (e.g. 1000), in base pairs

###step_4_to_5
Build non-overlapping blocks and get a tree for each block:
```shell
bash script/step_4_to_5.sh chromosome startingblockindex numblocks
```
Three parameters:
- chromosome (1-5, C or M)
- startingblockindex: starting block index (e.g. 0,1,…)
- numblocks: number of blocks to produce (e.g. 1,2,…)


###step6
Calculate Robinson-Foulds distances between trees:
```shell
raxmlHPC-PTHREADS-AVX -f r -z chr{*}.tre -n chr{*}dist -m GTRCAT --HKY85 -T 2
```
where {*}=2,C and M

###step7
Open `script/step7.R` in Rstudio and run codes.

|Step   |time cost     |where        |
|-------|-------------------------|-----------|
|step1  |5 hours|QV directory(not here)    |
|step2  |15 mins|  At directory(not here)|
|step3_pre  |5 hours|             QV_S directory(not here)|
|step4-5|17 hours |      [trees](https://github.com/UWMadison-computingtools/project1-team5/tree/master/trees)           |
|step6  |3 seconds |         [trees](https://github.com/UWMadison-computingtools/project1-team5/tree/master/trees)       |
|step7  |  1 seconds    |     [step7_plot](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/step7_plot.pdf)       |

Link
-------------
[**report.md**](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/report.md)
