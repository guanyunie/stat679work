#Report
##Step 1
Under the directory [project1-team5](https://github.com/UWMadison-computingtools/project1-team5), execute `bash script/step1.sh` to get 216 SNP files and store them into a directory `./data/QV`. At the same time, we get [qvfiles.csv](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/qvfiles.csv) file to store the data result, which include the total number of SNP files, SNP file name and the SNP file size.

There is another script [./script/step1_comprehensive.sh](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step1_comprehensive.sh). It is not used in following steps. However, by executing `bash script/step1_comprehensive.sh`, we can get more comprehensive SNP data files. It would contain all files in <http://signal.salk.edu/atg1001/data/Salk/> and <http://signal.salk.edu/atg1001/download.php>, and delete duplicate files automatically.


##Step2
This step is to get the 7 chromosome data files, and choose the 3 smallest chromosomes.(except chromosome 4)
By executing `bash script/step2.sh`, we can get 7 chromosome files, and store them in directory `./data/At`. At the same time, we can get [three_smallest_chro.csv](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/three_smallest_chro.csv). The three smallest chromosome files are chromosomeC, chromosomeM and chromosome2, with file size 156517, 371653 and 19947711 respectively


##Step3
This step is to get an alignment of the DNA sequences of all strains for a chromosome of interest and for a genomic range of interest. We use `python script/step3.py chromosome startingposition length` to execute. The three arguments:

- chromosome (in 1-5, C or M)

- startingposition (e.g. 1,2,…,20000,…), with indexing starting at 1 because “position” indices start at 1 in the SNP data files

- length (e.g. 1000), in base pairs

For example:

    10 10
    Aa_0 ATTTGGTTAT
    Abd_0 AATTGGTTAT
    Ag_0 AATTGGTTAT
    Ak_1 AATTGGTTAT
    Alst_1 AATTGGTTAT
    Altai_5 AATTGGTTAT
    Amel_1 AATTGGTTAT
    An_1 AATTGGTTAT
    Ang_0 AATTGGTTAT
    Anholt_1 AATTGGTTAT

At first, we used the algorithm that read through all lines above the endline. For example, if the input parameters are `"3" 200 300`, we have to read all the lines with chromosome `chr1`, `chr2` and first 300 lines of `chr3`. To speed up the algotithm, we first split all `qvfiles` by chromosome:
```shell
bash step_pre_3.sh
```
Then use grep to search only the lines with interested chromosome. Results turns out that this makes step3 much faster. Spliting the file takes about 8 hours. If the input parameters are `"1" 1 10000`, the first algorithm we used take about 3 minutes to get the output file, while the second one takes only several seconds.

##Step 4 to 5
This step is to cut a chromosome into non-overlapping alignments —or blocks— of length 10,000 base pairs (except for the last one) by calling step 3 in a for loop. It also contains step5, run RAxML and retain the main output file for each block from a given chromosome, starting at some block and for some number of blocks. One should use:
```shell
bash step_4_to_5.sh chromosome startingblockindex numblocks
```
to execute. The result should be like, for example:

    (Pog_0,((Es_0,Ha_0),(NC_6,Sg_1)),PHW_34)

The three arguments:

- chromosome (in 1-5, C or M)

- starting block index (e.g. 0,1,…)

- numblocks, number of blocks to produce (e.g. 1,2,…)

##Step6
Calculate the [Robinson-Foulds](https://en.wikipedia.org/wiki/Robinson–Foulds_metric)(RF) distance between pairs of (unrooted) trees.

```shell
raxmlHPC-PTHREADS-AVX -f r -z chr{*}.tre -n chr{*}dist -m GTRCAT --HKY85 -T 2
```
where {*}=2,C and M

The result should be like, for example:

    0 1: 400 0.938967
    0 2: 388 0.910798
    1 2: 390 0.915493


##Step7
This step is to test tree similarity. For each of chromosomeC, chromosomeM and chromosome2, we need to answer two question:

- (a): Are the observed tree distances closer to 0 than expected if the 2 trees were chosen at random uniformly?

- (b): Do trees from 2 consecutive blocks tend to be more similar to each other (at smaller distance) than trees from 2 randomly chosen blocks from the same chromosome?

We choose R language and the script is in [step7.R](https://github.com/UWMadison-computingtools/project1-team5/blob/master/script/step7.R). The result is in [step7_plot.pdf](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/step7_plot.pdf).


##Conclusion

In each of plots, we made the density function for two comparable functions respectively and plotted the mean value.
####For chromosome 2,  
(a)  
![alt text](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/chr2a.jpeg)

The observed tree distances are closer to 0 than expected if the 2 trees were chosen at random uniformly.  
(b)  
![alt text](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/chr2b.jpeg)

Trees from 2 consecutive blocks tend to be more similar to each other than trees from 2 randomly chosen blocks.   

####For chromosome C,
(a)  
![alt text](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/chrCa.jpeg)

The observed tree distances are closer to 0 than expected if the 2 trees were chosen at random uniformly.  
(b)  
![alt text](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/chrCb.jpeg)

Trees from 2 consecutive blocks tend to be more similar to each other than trees from 2 randomly chosen blocks, but the trend is much less than that of chr2.  

####For chromosome M,
(a)  
![alt text](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/chrMa.jpeg)

The observed tree distances closer to 0 than expected if the 2 trees were chosen at random uniformly, but the trend is much less than that of chr2.  
(b)  
![alt text](https://github.com/UWMadison-computingtools/project1-team5/blob/master/result/chrMb.jpeg)

Trees from 2 consecutive blocks tend to be more similar to each other than trees from 2 randomly chosen blocks, but the trend is much less than that of chr2.

Overall,  

- (a): The observed tree distances are closer to 0 than expected if the 2 trees were chosen at random uniformly.

- (b): Trees from 2 consecutive blocks tend to be more similar to each other (at smaller distance) than trees from 2 randomly chosen blocks from the same chromosome.
