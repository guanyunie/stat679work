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

Discreption
----------

**compare_dates.py:**  
Usage:  
In a python session, call `compare_date.compare_date(arg1, arg2)`  
Example:  
```shell
import compare_date
compare_date.compare_date("2016-07-12", "2016-08-10")
```
note: yyyy-mm-dd format should be used.

**merging.py:**  
Usage:  
In a python session, call `merging.merging(file1, file2)`  
Example:  
```shell
import merging
merging.merging("waterTemperature.csv","energy.csv")
```

