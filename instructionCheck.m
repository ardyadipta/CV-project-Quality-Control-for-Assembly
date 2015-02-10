function [] = instructionCheck(hObject,handles, im)
	%for goal pyramid
	%for goal lineup
	%for goal tower
	
	%check color until ok
	%filter image with yellow
	color_filtered = color_filter(im, handles.block_color{handles.step}, handles);
	% if (handles.step == 2) || (handles.step == 3)
	% 	color_filtered = color_filter(color_filtered, handles.block_color{handles.step}, handles);
	% 	color_filtered = color_filter(color_filtered, handles.block_color{handles.step}, handles);
	% 	color_filtered = color_filter(color_filtered, handles.block_color{handles.step}, handles);

	% end
		%if detected but not correctly placed, send feedback
	if any(color_filtered((handles.block_location{handles.step}(1) - handles.block_threshold), handles.block_location{handles.step}(2), : ))
			% check orientation until ok
		[orient, orient_fdbck] = check_angle(color_filtered,handles.block_orientation{handles.step}, handles.step, handles.goal);
		if orient
			[loc, loc_fdbck] = check_position(color_filtered, handles.block_location{handles.step});
			if loc
				if handles.step < 3
					set(handles.pushbutton8,'Visible','on');
					set(handles.text3, 'String', strcat('Awesome! Please proceed to next step'));
				else
					set(handles.text3, 'String', 'Congratulations!! You completed this puzzle! Try again? Select your new goal!');
					set(handles.axes1,'Visible','off');
					set(handles.axes2,'Visible','off');
					set(handles.axes3,'Visible','off');
					set(handles.text2,'Visible','off');
					set(handles.text14,'Visible','off');
					set(handles.text15,'Visible','off');
					set(handles.text16,'Visible','off');
					set(handles.text17,'Visible','off');
					set(handles.pushbutton1,'Visible','off');
					set(handles.pushbutton8,'Visible','off');
					set(handles.text9,'Visible','off');
					set(handles.text11,'Visible','off');
				end
			else
				set(handles.text3, 'String',loc_fdbck);
			end

		else
			set(handles.text3, 'String',orient_fdbck);
			return
		end


	else
		set(handles.text3, 'String', strcat('Put the box as instructed then click again for step ', int2str(handles.step)) );
		return
	end
	guidata(hObject, handles);
end
