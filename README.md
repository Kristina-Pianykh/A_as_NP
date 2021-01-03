# A_as_NP
This repository contains all the data, plots and codes, used in the following study:
Pianykh, K. (2019). Productivity of the A as NP construction in Russian and English: clear as mud or clear as day? Unpublished term paper.

## Data Structure
* The raw data, retrieved from the [Timestamped JSI web corpus 2019-08 English](https://www.sketchengine.eu/timestamped-english-corpus/) and the [Timestamped JSI web corpus 2014-2016 Russian](https://www.sketchengine.eu/timestamped-russian-corpus/), can be found in **raw/** folder.

* **scripts/** folder contains the py files, used to parse the raw data and extract the *A_as_NP* constructs into separate files for Russian and English. They are stored in **parsed/** folder. The R files contain the code, used for the following:
1. covarying-collexeme analysis;
2. building vocabulary growth curves (VGCs) with the help of LNRE models.

The py files contains the code for computing ΔP for each *A as NP* type and appendinng the results to the original file.

* The results, yielded by the co-varying collexeme analysis, performed on the Russian and English data, can be found in **results/** folder.
