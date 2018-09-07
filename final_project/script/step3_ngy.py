import re
import os
import sys

def build_individual_genomes(chromosome, position, length):

    position = int(position)
    length = int(length)

    with open("chr%s_%dto%d.phy" % (chromosome, position, position+length-1), 'w') as out:
        out.write("216 "+ str(length) + "\n")

    with open('./data/At/TAIR10_chr%s.fas' % chromosome, 'r') as myfile:
        next(myfile)
        DNA = myfile.read().replace('\n', '')

    targets = []
    for qvfile in os.listdir("data/QV_S/"):
        if qvfile.endswith("chr%s.txt" % chromosome):
            target = re.sub('(.*)_(.*)\.txt', r'\1 ', qvfile)
            with open("data/QV_S/" + qvfile, "r") as individual:
                original = {}
                updated = {}
                for line in individual:
                    if re.search("chr" + chromosome, line):
                        info = re.split('\t', line)
                        patient = info[0]
                        chro = info[1]
                        pos = int(info[2])
                        orig = info[3]
                        changed = info[4]
                        original[pos] = orig
                        updated[pos] = changed

                        if pos>position+length:
                            break

                        assert original[pos] == DNA[pos-1], "Error: not match"

                target_sequence = ''
                for i in list(range(position, position+length)):
                    if i in original.keys():
                        target_sequence = target_sequence + updated[i]
                    else:
                        target_sequence = target_sequence + DNA[i-1]

                target = target + target_sequence
                targets.append(target)

    with open("chr%s_%dto%d.phy" % (chromosome, position, position+length-1), 'a') as out:
        for i in targets:
            out.write(i)
            out.write("\n")

if __name__ == '__main__':
   build_individual_genomes(*sys.argv[1:])
