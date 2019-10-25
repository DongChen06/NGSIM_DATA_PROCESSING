%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cem Sazara - October 2017
% 
% NGSIM I-80 Vehicle Trajectories
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
%clear all
close all;

trajectories = load('trajectories.mat');
trajectories = trajectories.data_file;
% Section limits can be adjusted, here it is 200-800 feets (600 feets long)
time_interval = [350 1600];

% Limits of x-y axis
x_limit = [time_interval(1)-5 time_interval(2)+5];
y_limit = [-20 90];
unique_frames = unique(trajectories(:,2));

for i=450:length(unique_frames)
    frameData = trajectories(trajectories(:,2)==unique_frames(i) & ...
        trajectories(:,6)>=time_interval(1) & ...
        trajectories(:,6)<=time_interval(2),:);
    
    if isempty(frameData)
       continue; 
    end
    
    % Get needed fields
    lateral_y = frameData(:,5);
    longitude_x = frameData(:,6);
    v_id = num2str(frameData(:,1));
    v_length = frameData(:,9);
    v_width = frameData(:,10);
    v_class = frameData(:,11);
    
    % Construct vehicle bounding boxes
    boundingBoxArr = [longitude_x - v_length, lateral_y - v_width/2, v_length, v_width];
    
    title(strcat('NGSIM Trajectories - Frame:', num2str(unique_frames(i))))
    % Plot road boundaries
    line(x_limit,[-2 -2],'Color','k','LineStyle','-', 'LineWidth',2)
    line(x_limit,[75 75],'Color','k','LineStyle','-','LineWidth',2)

    % Plot lane markers
    line(x_limit,[11.5 11.5],'Color','blue','LineStyle','--', 'LineWidth',0.5)
    line(x_limit,[23.5 23.5],'Color','blue','LineStyle','--','LineWidth',0.5)
    line(x_limit,[35 35],'Color','blue','LineStyle','--', 'LineWidth',0.5)
    line(x_limit,[48 48],'Color','blue','LineStyle','--', 'LineWidth',0.5)
    line(x_limit,[60 60],'Color','blue','LineStyle','--', 'LineWidth',0.5)

    % Plot vehicle bounding boxes according to vehicle class
    % Red -> Motorcycle, Yellow-> Auto, Green-> Truck
    for j=1:length(boundingBoxArr(:,1))
        hold on
        if(v_class(j) == 1)
            rectangle('Position', boundingBoxArr(j,:), 'FaceColor', [1 0 0])
        elseif (v_class(j) == 2)
            rectangle('Position', boundingBoxArr(j,:), 'FaceColor', [1 1 0])
        else
            rectangle('Position', boundingBoxArr(j,:), 'FaceColor', [0 1 0])
        end
    end
    
    % Add vehicle id to each vehicle
    text(longitude_x - 2 * v_length / 3, lateral_y,v_id, 'color', 'b', 'Margin', 0.1, 'FontSize',6, 'clipping','on')
    
    % Create custom legend for vehicle classes
    h = zeros(3, 1);
    h(1) = plot(NaN,NaN,'sr', 'MarkerFaceColor',[1,0,0]);
    h(2) = plot(NaN,NaN,'sy', 'MarkerFaceColor',[1,1,0]);
    h(3) = plot(NaN,NaN,'sg', 'MarkerFaceColor',[0,1,0]);
    lgd = legend(h, 'Motorcycle','Auto','Truck', 'Location','northeast','Orientation','horizontal');
    set(lgd,'FontSize',8)
    
    xlim(x_limit)
    ylim(y_limit)
    xlabel('Longitude_x (feet)')
    ylabel('Lateral_y (feet)')
    
    set(gca,'Ydir','reverse')
    grid on
    
    pause(0.001)
    clf('reset')
end

