#!/usr/bin/env python
import re
import os
import sys

# a function with arguments chromosome, position, length and return the target DNA sequence we need.
def build_individual_genomes(chromosome, position, length):

    position = int(position)
    length = int(length)

    #store the things we find.
    with open("chr%s_%dto%d.phy" % (chromosome, position, position+length-1), 'w') as out:
        out.write("216 "+ str(length) + "\n")

    with open('./data/At/TAIR10_chr%s.fas' % chromosome, 'r') as myfile:
        next(myfile)#skip the first line, it's not what we needed.
        DNA = myfile.read().replace('\n', '')

    targets = []
    for qvfile in os.listdir("data/QV/"): #for each SNP file
        target = re.sub('quality_variant_(.*)\.txt', r'\1', qvfile)#find the name.
        fileName="%s_chr%s.txt" % (target, chromosome)
        with open("data/QV_S/" + fileName, "r") as individual:
            original = {}
            updated = {}
            for line in individual:
                #for each line in each SNP, splite each column to get what we need later.
                if re.search('chr'+str(chromosome),line):
                    info = re.split('\t', line)
                    patient = info[0]
                    chro = info[1]
                    pos = int(info[2])
                    orig = info[3]
                    changed = info[4]
                    original[pos] = orig
                    updated[pos] = changed
                    #save time
                    if pos>position+length:
                        break
                    #assert the match
                    assert original[pos] == DNA[pos-1], "Error! Not match!"
                info = re.split('\t', line)
                patient = info[0]
                chro = info[1]
                pos = int(info[2])
                orig = info[3]
                changed = info[4]
                original[pos] = orig
                updated[pos] = changed
                #save time
                if pos>position+length:
                    break

                assert original[pos] == DNA[pos-1], "Error: not match"
            #replace to get what we need , the DNA sequence.
            target_sequence = ''
            for i in list(range(position, position+length)):
                if i in original.keys():
                    target_sequence = target_sequence + updated[i]
                else:
                    target_sequence = target_sequence + DNA[i-1]

            target = target + " " + target_sequence
            targets.append(target)
#write append to the csv file.
    with open("chr%s_%dto%d.phy" % (chromosome, position, position+length-1), 'a') as out:
        for i in targets:
            out.write(i)
            out.write("\n")

if __name__ == '__main__':
   build_individual_genomes(*sys.argv[1:])
