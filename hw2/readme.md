homework 2: merging data files
==============================

Directory
----------

- hw/
  - **compare_dates.py**:  
    function used to compare dates
  - **merging.ipynb**:  
    testing code before write it into python script
  - **merging.py**:  
    module contains merging two files function
  - **output.csv**:  
    final output of merging data

Assumption
----------

In this homework we are making an assumption that all times within one day are ordered.

Useage
----------

Can be called by command line:

```shell
IPython
import compare_date
import merging
merging.merging("waterTemperature.csv","energy.csv")
```

