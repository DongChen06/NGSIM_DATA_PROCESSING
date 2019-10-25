clc
clear all
close all

%% precessing data

% data_loaded = load('lane_1.mat');
% data_loaded = data_loaded.lane_1;

trajectories = load('trajectories.mat');
trajectories = trajectories.data_file;

% lane_id = 1; % lane 1
% cars = [448, 440, 425, 426, 416];  % vehicle ID, from entering to output  
% t = [524, 763]; % [time_start, time_end] = [time that 448 entering, time that 416 leaves]

% lane_id = 2;   % lane 2
% cars = [444, 439, 432, 419, 402];
% t = [461, 829]; 

% lane_id = 3;  % lane 3
% cars = [445, 433, 421, 413, 401]; 
% t = [461, 829]; 

lane_id = 4;  % lane 4
cars = [482, 465, 455, 446, 438]; 
t = [564, 942]; 

% lane_id = 5;  % lane 5
% cars = [445, 433, 421, 413, 401]; 
% t = [461, 829]; 

len = length(cars);
data2save = {};

for i=t(1):t(2)
    frame_data = zeros(len,4);
    for j=1:len
        frameData = trajectories(trajectories(:,2)== i & ...
            trajectories(:,1)== cars(j),:);
        frame_data(j, :) = [j, frameData(12), frameData(13), frameData(17)];
    end
    data2save(i - t(1) + 1,:) = {i - t(1) + 1, frame_data};
end

save('output/lane_4.mat', 'data2save')
