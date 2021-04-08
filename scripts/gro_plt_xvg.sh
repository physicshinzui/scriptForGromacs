#!/Users/siida/anaconda3/bin/python
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
import sys

def read_rmsd_xvg(filename):
    with open(filename, 'r') as fin:
        frame = []
        for line in fin:
            line = line.strip()

            if line[0]=='#' or line[0]=='@':
                continue

            else:
                time, rmsd = float(line.split()[0]), float(line.split()[1])
                frame.append([time, rmsd])

    rmsds = np.array(frame)
    return rmsds

def main():

    inp = sys.argv[1]
    rmsds = read_rmsd_xvg(inp)
#    plt.plot(rmsds[:,0], rmsds[:,1], alpha=1)
#    plt.ylim(0,0.4)

    params = sys.argv[1:]
    rmsd_inps, style = params[0:-1], params[-1]
    print(rmsd_inps, style)
#
#Note: this function works such that yticks labels are removed.
    fig, axes = plt.subplots(nrows=len(rmsd_inps), ncols=1, figsize=(10,14)) #(10,7)
    colors = cm.rainbow(np.linspace(0, 1, len(rmsd_inps)))
    #for i, inp in enumerate(rmsd_inps):
    for i, ax in enumerate(axes):
        inp = rmsd_inps[i]
        print(inp)
        rmsds = read_rmsd_xvg(inp)
        if style=='plot':
            ax.plot(rmsds[:,0], rmsds[:,1], label=f'Traj{i}', alpha=1, c = 'black')
            #ax.set_xlim(0,0.4)
            ax.set_ylim(0,0.5)
            ax.set_yticks([0,0.25,0.5])
            #ax.legend()

        elif style=='hist':
            plt.hist(rmsds[:,1], bins=25, alpha=1, histtype='step', linewidth=3, label=f'Traj{i}' )
        else:
            sys.exit('specify type')

    plt.tight_layout()
    plt.savefig('fig.png',dpi=300)
    plt.show()



if __name__ == '__main__':
    main()
