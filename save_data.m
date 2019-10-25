clc
clear all
close all

%% precessing data

% data_loaded = load('lane_1.mat');
% data_loaded = data_loaded.lane_1;

trajectories = load('trajectories.mat');
trajectories = trajectories.data_file;

lane_id = 1; % lane 1
cars = [448, 440, 425, 426, 416];  % vehicle ID, from entering to output  
t = [524, 763]; % [time_start, time_end] = [time that 448 entering, time that 416 leaves]

% lane_id = 2;   % lane 2
% cars = [444, 439, 432, 419, 402];
% t = [461, 829]; 

% lane_id = 3;  % lane 3
% cars = [445, 433, 421, 413, 401]; 
% t = [461, 829]; 

% lane_id = 4;  % lane 4
% cars = [482, 465, 455, 446, 438]; 
% t = [564, 942]; 

% lane_id = 5;  % lane 5
% cars = [445, 433, 421, 413, 401]; 
% t = [461, 829]; 

len = length(cars);
data2save = {};

for j=1:len
    frameData = trajectories(trajectories(:,1)== cars(j) & ...
      trajectories(:,2) >= t(1) &  trajectories(:,2) <= t(2),:);
    frame_data = [frameData(:,12), frameData(:,13), frameData(:,17)] * 0.3048;
%     frame_data = [frameData(:, 1),frameData(:, 2), frameData(:,12), frameData(:,13), frameData(:,17)] .* [1, 1, 0.3048, 0.3048, 0.3048];
    data2save(j,1) = {frame_data};
end


save('output/lane_1.mat', 'data2save')
