# TMS click masking
Noise masking for TMS click sound to avoid auditory artifacts during concurrent EEG recording. 

## Instructions
Download the folder. Set the directory to your folder on Matlab. Run noise_masking.m 
The folder includes a recorded sample of a TMS click at %45 stimulation output intensity. 

## Requirements
Matlab & Signal Processing Toolbox 

## Method
The noise masking method is based on https://www.jneurosci.org/content/jneuro/35/43/14435.full.pdf
The sound is first trimmed, then Fourier transformed. The phase of each frequency bin is shuffled and 
concatenated together to make a continuous stream of noise.



