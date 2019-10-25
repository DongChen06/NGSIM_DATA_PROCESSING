
NGSIM DATA PROCESSING
===============

- Built by Dong Chen, Zhaojian Li from Michigan State University
- Started on Oct.23, 2019, Lastly updated on Oct.25, 2019

Overview
-------

This resposity aims at 

#### Motivation:
To be added...

Part1. Project Building On Ubuntu
-------

### Object Detection Module
To be added...

### Lane Deviation Module

This module is built on the resposity: [Resposity Link](https://github.com/ndrplz/self-driving-car/tree/master/project_4_advanced_lane_finding).

Modification logs:
- [x] Delete the display code for "intermediate pipeline images", here we only display the lane deviation and lane curvature.
- [x] Clasify codes.
- [ ] Problems with road curvature and offset values are always positive.

### Distance Estimation Module
47o FOV len.

<p align="center">
     <img src="./traffic_project/Docs/distance_estimation.png" alt="output_example" width="60%" height="60%">
     <br>Distance Estimation
</p>
When camera pitch angle is negligibly small, range d to vehicle can be calculated as in the following: 

```
    d = F_c * H_c / (y_b - y_h)
```

Part2. Project Building On Android
-------

To be added...
