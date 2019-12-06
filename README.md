
NGSIM DATA PROCESSING
===============
#### Robotics and Intelligent Vehicle Automation Lab (RIVAL)
- Built by Dong Chen, [Zhaojian Li](https://www.egr.msu.edu/rival/) from Michigan State University
- Started on Oct.23, 2019, Lastly updated on Oct.25, 2019

Overview
-------

This resposity aims at building car following dataset. We use a subset of NGSIM dataset, full dataset can be found [here](https://data.transportation.gov/Automobiles/Next-Generation-Simulation-NGSIM-Vehicle-Trajector/8ect-6jqj).

#### Motivation:
Next Generation Simulation (NGSIM) program collected vehicle trajectory data on southbound US 101 and Lankershim Boulevard in Los Angeles, CA, eastbound I-80 in Emeryville, CA and Peachtree Street in Atlanta, Georgia. We want to find the trajectories of vehicles and fit the data to our car-following model. This resposity aims at find sequences of vehicles and corresponding trajectory information where the vehicles inside the sequences follow each other without lane changing or extra vehicles enter the sequences during a time interval.

Part1. Lane Change Analysis
-------
There are three subdataset. We use the dataset *Data-0500-0515*, the dataset shows like this.

<p align="center">
     <img src="docs/trajectory16.png" alt="output_example" width="60%" height="60%">
     <br>Fig.1 Column 1-6 of Data-0500-0515
</p>

<p align="center">
     <img src="docs/trajectory712.png" alt="output_example" width="60%" height="60%">
     <br>Fig.2 Column 7-12 of Data-0500-0515
</p>

<p align="center">
     <img src="docs/trajectory1318.png" alt="output_example" width="60%" height="60%">
     <br>Fig.3 Column 13-18 of Data-0500-0515
</p>

Part2. Trajectory Plotting
-------

To be added...


Part3. Data Saving
-------


Reference
----------
[1]. [Next Generation Simulation (NGSIM) Vehicle Trajectories and Supporting DataAutomobiles](https://data.transportation.gov/Automobiles/Next-Generation-Simulation-NGSIM-Vehicle-Trajector/8ect-6jqj)


