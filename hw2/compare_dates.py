import re

def compare_dates(date1, date2):
    """return if date1 is earlier than date2
    Format yyyy-mm-dd should be used."""

    year1 = re.sub(r'^(\d+)-.*', r'\1', date1)
    year2 = re.sub(r'^(\d+)-.*', r'\1', date2)
    month1 = re.sub(r'.*-(\d+)-.*', r'\1', date1)
    month2 = re.sub(r'.*-(\d+)-.*', r'\1', date2)
    day1 = re.sub(r'.*-(\d+)$', r'\1', date1)
    day2 = re.sub(r'.*-(\d+)$', r'\1', date2)
    if year1 > year2:
        return False
    elif year1 < year2:
        return True
    else:
        if month1 > month2:
            return False
        elif month1 < month2:
            return True
        else:
            if day1 > day2:
                return False
            else:
                return True
