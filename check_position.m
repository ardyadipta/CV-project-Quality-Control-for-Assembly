function [loc, loc_fdbck] = check_position(color_filter, block_location)
%Function to check orientation of block

%Automatic variable returns
loc = 0;
loc_fdbck = 'Incorrect Position';

%Sobel Edge Detection
BW_left = edge(im2double(rgb2gray(color_filter)),'sobel');

%Find vertical lines of image
left_col_value = zeros(1,floor(size(BW_left,2)));
for left_cols = 1:length(left_col_value)
    left_col_value(left_cols) = sum(BW_left(:,left_cols));
end

%Find left and middle edges
[~,left_columns] = find(left_col_value);
%Adjust for sobel edge detection double line
left_edge = min(left_columns)+8;

%Find bottom end of vertical line
row_value = zeros(1,floor(size(BW_left,1)));
for rows = 1:length(row_value)
    row_value(rows) = sum(BW_left(rows,:));
end
%Find bottom of edge
[~,bottoms] = find(row_value);
bottom_edge = max(bottoms)-9;


%Calculate location of block bottom center
normal_block_width = 242; %pixels = 2.25 inches
bottom_center = [bottom_edge, left_edge + normal_block_width/2];%[y,x]

%Compare found location to desired location
difference = block_location(2) - bottom_center(2);

%242 pixels = 2.25 inches
ratio = 1/108;% inch/pixel

%Round and convert to string as inch
dist = num2str(round(abs(difference)*ratio*100)/100);

%Good if within 1/8th inch
left_threshold = 14; %pixels = 1/8th inch
right_threshold = -14; %pixels = 1/8th inch
close_threshold = -25; %pixels 
far_threshold = 25; %pixels 


%Give Feedback for left and right only
if difference < left_threshold && difference > right_threshold
    %Correct
    loc = 1; 
    loc_fdbck = 'Correct';
end

if difference > left_threshold
    loc = 0;
    loc_fdbck = sprintf('Please move the block %s inches to the right', dist);
end

if difference < right_threshold
    loc = 0;
    loc_fdbck = sprintf('Please move the block %s inches to the left', dist);
end

% %Check depth of blocks on ground
% if block_location(1) == 765
%     depth = block_location(1) - bottom_center(1);
%     if depth < close_threshold
%         loc = 0;
%         loc_fdbck = cat(2,loc_fdbck,', Please move the block back behind the dashed line');
%     end
%     if depth > far_threshold
%         loc = 0;
%         loc_fdbck = cat(2,loc_fdbck,', Please move the block up to the dashed line');
%     end
% end

end


