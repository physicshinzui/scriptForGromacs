#!/Users/siida/anaconda3/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sys import exit

def main():
    
    files = sys.argv[1:]

    fig, axes = plt.subplots(nrows=len(files), ncols=1)
    for ifile in files:

        series = np.loadtxt(ifile)
        


if __name__ == "__main__":
    main()

