%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2019 {Dong Chen, Zhaojian Li} <{chendon9@msu.edu}>
% This file is part of ACC2020.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all


%% create the mat file
% data_file = csvread('trajectories_0500_0515_Copy.csv', 1);
% save('data_I_80_0500_0515.mat','data_file');

%% precessing data
trajectories = load('trajectories.mat');
trajectories = trajectories.data_file;
% Section limits can be adjusted, here it is 200-800 feets (600 feets long)
longitudinal_range = [350 1600];

% Limits of x-y axis
x_limit = [longitudinal_range(1)-5 longitudinal_range(2)+5];
y_limit = [-20 90];
unique_frames = unique(trajectories(:,2));
lane_id = 5; 

% compute the number of unique vehicles in the lane

% v_id, Preceeding, Forwarding, start_frame, end_frame, start_y, end_y,
% lane_change_flag
buffer = zeros(3000, 8);
for i=450:length(unique_frames)
    if mod(unique_frames(i), 1000) == 0
        fprintf('Frame_id is = %d\n', unique_frames(i))
    end
    frameData = trajectories(trajectories(:,2)==unique_frames(i) & ...
        trajectories(:,6)>=longitudinal_range(1) & ...
        trajectories(:,6)<=longitudinal_range(2) & trajectories(:,14) == lane_id,:);
    
    if isempty(frameData)
        continue; 
    end

    for j=1:size(frameData, 1)
        % the first time entering the lane
        if sum(find(frameData(j,1) == buffer(:,1))) == 0
            % insert the element into the buffer according to the local_y
            % coordinates in descending sequence.
            % Two cases: entering the lane from the start point or
            % changing lane to this lane.
            trajectory = trajectories(trajectories(:,2) == unique_frames(i-30) & ...
              trajectories(:,1)  == frameData(j,1), :);
           if trajectory(14) ~=  lane_id
                % to be lane changing to this lane
                row_id = find(frameData(j,6) > buffer(:,7));
                rowToInsert = row_id(1) - 1;
                rowVectorToInsert = [frameData(j,1), frameData(j,15), ...
                    frameData(j,16), unique_frames(i), unique_frames(i), frameData(j,6), frameData(j,6),1];
                buffer = [buffer(1:rowToInsert-1,:); rowVectorToInsert; buffer(rowToInsert:end-1,:)];
           else
               rowToInsert = sum(buffer(:,7) > 0);
               % it enters the lane from the start point
               rowVectorToInsert = [frameData(j,1), frameData(j,15), ...
                    frameData(j,16), unique_frames(i), unique_frames(i), frameData(j,6), frameData(j,6),0];
               buffer(rowToInsert+1, :) =  rowVectorToInsert;
           end
           
        else
            v_id = find(frameData(j,1) == buffer(:,1));
            buffer(v_id, 2) =  frameData(j,15);
            buffer(v_id, 3) =  frameData(j,16);
            buffer(v_id, 5) =  unique_frames(i);
            buffer(v_id, 7) =  frameData(j,6);
        end
        
    end

end

% consider the cars which change lane from this lane to other lane, then we
% should a lane change flag
buffer(buffer(:, 7) <= longitudinal_range(2) - 10 & ...
buffer(:, 7) ~= 0, 8) = 1;
% compute the last frames
rows = sum(buffer(:,1) > 0);
lane_5 = [buffer(1:rows,1:5), buffer(1:rows,5) - buffer(1:rows,4), buffer(1:rows,6:8)];
save('lane_analysis/lane_analysis_5.mat','lane_5');
