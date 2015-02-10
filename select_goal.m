function  []= select_goal(hObject,handles)
	set(handles.text10,'String', handles.goal);
	set(handles.axes1,'Visible','on');
	set(handles.text9,'Visible','on');
	set(handles.text11,'Visible','on');
	set(handles.text16,'Visible','on');

	set(handles.text17,'Visible','on');
	set(handles.pushbutton1,'Visible','on');
	axes(handles.axes1);
	handles.step = 1;
	
	
	if strcmp(handles.goal,'pyramid')
		imshow('button_pyramid.jpg');
		handles.block_color{1} = 'yellow';
		handles.block_color{2} = 'blue';
		handles.block_color{3} = 'red';

		handles.instruction_set{1} = strcat('First, put the ', handles.block_color{1}, ' box with the front edge on the dashed line and the right edge on the dot line');
		handles.instruction_set{2} = 'Second, put the blue box with the front edge on the dashed line and the left edge touch the yellow box';
		handles.instruction_set{3} = 'Finally, put the red box on top of the middle of the blue box and yellow box';

		handles.block_location{1} = handles.left_center ;
		handles.block_location{2} = handles.right_center;
		handles.block_location{3} = handles.second_top;

		handles.block_orientation{1} = 0;
		handles.block_orientation{2} = 0;
		handles.block_orientation{3} = 0;
		


	elseif strcmp(handles.goal,'lineup')
		imshow('button_lineup.jpg');
		
		handles.block_color{1} = 'yellow';
		handles.block_color{2} = 'blue';
		handles.block_color{3} = 'red';

		handles.instruction_set{1} = strcat('First, put the ', handles.block_color{1}, ' box with the front edge on the dashed line');
		handles.instruction_set{2} = 'Second, put the blue box on the left of the yellow box ';
		handles.instruction_set{3} = 'Finally, put the red box on the right of the red box';

		handles.block_location{1} = handles.center;
		handles.block_location{2} = handles.left_center - [0, 122];
		handles.block_location{3} = handles.right_center  + [0, 122];

		handles.block_orientation{1} = 0;
		handles.block_orientation{2} = 0;
		handles.block_orientation{3} = 0;



	elseif strcmp(handles.goal,'tower')
		imshow('button_tower.jpg');
		handles.block_color{1} = 'yellow';
		handles.block_color{2} = 'blue';
		handles.block_color{3} = 'red';

		handles.instruction_set{1} = strcat('First, put the ', handles.block_color{1}, ' box with the front edge on the dashed line');
		handles.instruction_set{2} = 'Second, put the blue box on top of the yellow box ';
		handles.instruction_set{3} = 'Finally, put the red box on top of the blue box';

		handles.block_location{1} = handles.center;
		handles.block_location{2} = handles.second_top;
		handles.block_location{3} = handles.top;

		handles.block_orientation{1} = 0;
		handles.block_orientation{2} = 0;
		handles.block_orientation{3} = 0;


	end
	
	set(handles.text2,'Visible','on');
	set(handles.text2, 'String', handles.instruction_set{1});
	guidata(hObject,handles);

