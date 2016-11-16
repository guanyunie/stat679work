import re
from os.path import exists
import csv
from compare_dates import compare_dates

def merging(f1, f2):
    """f1 should be waterTemperature csv file, f2 should be energy csv file.
    Output of the function will be a new csv file merging two files."""

    # check if the two file exist
    assert exists(f1), "waterTemperature does not exist."
    assert exists(f2), "energy does not exist."

    # store energy date in energyDate and energy in energyValue
    with open(f2,"r") as energy:
        energyDate = []
        energyValue = []
        for line in energy:
            if re.search(r'(\d+)-(\d+)-(\d+).*', line):
                date = re.sub(r'^(\d+)-(\d+)-(\d+).*', r'\1-\2-\3', line)
                energyDate.append(date.rstrip())
                value = re.sub(r'.*,(\d+)$', r'\1', line)
                energyValue.append(value.rstrip())

    n_energy = 1
    currentEnergyDay = energyDate[n_energy-1]
    # index stores the line number in waterTemperature.csv that need to add energy value
    index = []

    # Get index that should be appended
    with open(f1,"r") as temperature:
        for line in temperature:
            if re.search(r'^(\d+).*', line):
                line = line.rstrip()
                day = re.sub(r'^(\d+),(\d+)/(\d+)/(\d+) (\d+).*', r'20\4-\2-\3', line)

                #if day greater than currentEnergyDay, get that line number and store it into index
                if compare_dates(day, currentEnergyDay) is False:
                    index.append(int(re.sub(r'^(\d+),.*', r'\1', line)) - 1)
                    n_energy += 1
                    currentEnergyDay = energyDate[n_energy-1]

    with open(f1, "r") as f:
        waterTemperature = [line.rstrip('\n').split(",") for line in f if line.rstrip('\n') != '']

        for i in range(0, len(index)-1):
            waterTemperature[index[i] + 1].append(str(float(energyValue[i+1])/1000))

        #Formatting
        waterTemperature.pop(0)
        waterTemperature.pop(0)

        #write output to "output.csv"
        with open("output.csv",'w', newline='') as n:
            w = csv.writer(n)
            w.writerow(["Plot Title: 10679014 jackson July29"])
            w.writerow(["#","Date Time, GMT-05:00","K-Type, °F (LGR S/N: 10679014, SEN S/N: 10679014, LBL: water pipe)","energy"])
            w.writerows(waterTemperature)
