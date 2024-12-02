***********************************************************************
 Simulation code from Durstewitz & Gabriel (2006), "Dynamical basis of 
 irregular spiking in NMDA-driven prefrontal cortex neurons", Cerebral
 Cortex
***********************************************************************

This archive should contain all files needed to run the network and 
single neuron simulations from the paper above. For single neurons, 
both NEURON and MatLab-based code is provided (for both runSglPCwcNMDA.m
is the ML-wrapper).

Please note that many network parameters are initialized according to 
random distributions (with given mean & stdv). Precise parameter 
configurations could therefore depend on the way the random number 
generator is implemented and initialized (and on processor type).
The paramter configuration on which the simulations in the paper were 
based is provided here in the file 'NetPar0.par'.

The simulation files expect a directory called 'out' in the current path.

For questions or comments please contact:
Dr Daniel Durstewitz
Centre for Theoretical and Computational Neuroscience
University of Plymouth
Portland Square, A 220
Plymouth, PL4 8AA, UK
daniel.durstewitz@plymouth.ac.uk

Copyright (C) 2006 for all software in this package by the Authors of
the above cited paper. This software may be used under the terms of the 
General Public License (www.gnu.org/copyleft/gpl.txt).

Note from the ModelDB administrator:
The network model run after the mod files are compiled
nrngui runThis.hoc
takes about 4 hours to complete and writes about 1.2GB of the 125 cells
voltage traces into the out directory.

The model files are also available at the author's web site:

http://www.pion.ac.uk/~daniel/

A network demo runs the network for a short time to
verify that the code is compatible with your version of neuron:
nrngui mosinit.hoc
and then select the network demo run.

The model has been verified to run on linux, mac os x, and ms win.

On the mac drag the DynBasIrregSpNMDA folder to the mknrndll icon
in the NEURON folder.  Then drag the mosinit.hoc file to nrngui to
start the simulation.

In unix, ms win compile the mod file using mknrndll, then start the
simulation by running nrngui mosinit.hoc (unix) or double clicking on
the mosinit.hoc file (ms win).

Changelog
---------
2024-11: Updated hoc files to use Random123
