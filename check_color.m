function isColor = check_color(hObject,handles, im)
	% if strcmp(goal, 'pyramid') % if we would like to build pyramid
	% 	% if pyramid, block 1 yellow, 2, red and 3 blue
	% 	if block_number == 2

	if strcmp(goal, 'tower') % if we would like to build pyramid
		% if pyramid, block 1 yellow, 2 red and 3 blue
		if block_number == 2 % then should be blue
			if im((handles.location_block2(1) - handles.block_threshold), handles.location_block2(2))
				isColor = true;
			else
				isColor = false;
			end

		else
			isColor = false;
		end
	else
		isColor = false;
	end


