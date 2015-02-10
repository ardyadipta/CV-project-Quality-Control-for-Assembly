function [orient, orient_fdbck] = check_angle(color_filter,block_angle,step,goal)
%Function to check orientation of block

%Automatic variable returns
orient = 0;
orient_fdbck = 'Incorrect Angle';

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
mid_edge = max(left_columns)-8;


%Calculate line that connects edges
line1 = (mid_edge - left_edge)
n = 0;
if step == 2 && strcmp(goal,'tower')
    n = 30
    line1 = line1 + n;
end

if step == 3 && strcmp(goal,'tower')
    n = 15
    line1 = line1 + n;
end

if step == 3 && strcmp(goal,'pyramid')
    n = 5
    line1 = line1 + n;
end


%For perpedicular block assembly
if block_angle == 0
    %Give Feedback
    if line1 >= 270 
        orient = 0;
        orient_fdbck = 'Angle is Incorrect';
    end

    if line1 < 270 && line1 >= 220
        %Correct
        orient = 1;
        orient_fdbck = 'Correct';
    end

    if line1 < 220 && line1 >= 212

        orient = 0;
        orient_fdbck = 'Please turn the block counter-clockwise by 15 degrees';
    end

    if line1 < 212 && line1 >= 176

        orient = 0;
        orient_fdbck = 'Please turn the block counter-clockwise by 30 degrees';
    end

    if line1 < 176 && line1 >= 130

        orient = 0;
        orient_fdbck = 'Please turn the block clockwise by 45 degrees';
    end

    if line1 < 130 && line1 >= 77

        orient = 0;
        orient_fdbck = 'Please turn the block clockwise by 30 degrees';
    end

    if line1 < 77 && line1 >= 40

        orient = 0;
        orient_fdbck = 'Please turn the block clockwise by 15 degrees';
    end

    if line1 < 40

        orient = 0;
        orient_fdbck = 'Close, but please turn the block clockwise by 5 degrees';
    end
end

%For 45 degree block assembly
if block_angle == 45
    %Give Feedback
    if line1 >= 250
        orient = 0;
        orient_fdbck = 'Please place the block behind the dashed line';
    end

    if line1 < 250 && line1 >= 235
        %Correct
        orient = 0;
        orient_fdbck = 'Please turn the block clockwise by 45 degrees';
    end

    if line1 < 235 && line1 >= 212

        orient = 0;
        orient_fdbck = 'Please turn the block clockwise by 30 degrees';
    end

    if line1 < 212 && line1 >= 176

        orient = 0;
        orient_fdbck = 'Please turn the block clockwise by 15 degrees';
    end

    if line1 < 176 && line1 >= 130

        orient = 1;
        orient_fdbck = 'Correct';
    end

    if line1 < 130 && line1 >= 77

        orient = 0;
        orient_fdbck = 'Please turn the block counter-clockwise by 15 degrees';
        
    end

    if line1 < 77 && line1 >= 40

        orient = 0;
        orient_fdbck = 'Please turn the block counter-clockwise by 30 degrees';
        
    end

    if line1 < 40

        orient = 0;
        orient_fdbck = 'Please turn the block counter-clockwise by 40 degrees';
    end
end

end


