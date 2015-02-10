function color_filtered = color_filter(im, color, handles)

	if strcmp(color, 'blue')	
		r=im(:,:,1); g=im(:,:,2); b=im(:,:,3);
		diff=imsubtract(b,rgb2gray(im));
		bw=im2bw(diff,0.18);
		area=bwareaopen(bw,300);
		bm=immultiply(area,b);  gm=g.*0;  rm=r.*0;
		color_filtered=cat(3,rm,gm,bm);
		if nargin == 3 
			set(handles.axes3,'Visible','on');
			axes(handles.axes3);
			imshow(color_filtered);
		end

	elseif strcmp(color, 'red')
		r=im(:,:,1);
		g=im(:,:,2); b=im(:,:,3);
		diff=imsubtract(r,rgb2gray(im));
		bw=im2bw(diff,0.18);
		area=bwareaopen(bw,300);
		
		rm=immultiply(area,r);  gm=g.*0;  bm=b.*0;
		color_filtered=cat(3,rm,gm,bm);
		if strcmp(handles.goal, 'pyramid') && (handles.step == 3)
			color_filtered(540:1:size(color_filtered,1), :,:) = 0;
		end

		if strcmp(handles.goal, 'lineup') && (handles.step == 3)
			color_filtered(540:1:size(color_filtered,1),736:-1:1,:) = 0;
		end

		if strcmp(handles.goal, 'tower') && (handles.step == 3)
			color_filtered(size(color_filtered,1)/2:1:size(color_filtered,1), :,:) = 0;
		end

		if nargin == 3
			set(handles.axes3,'Visible','on');
			axes(handles.axes3);
			imshow(color_filtered);
		end

	elseif strcmp(color, 'green')
		r=im(:,:,1);
		g=im(:,:,2); b=im(:,:,3);
		diff=imsubtract(g,rgb2gray(im));
		bw=im2bw(diff,0.18);
		area=bwareaopen(bw,300);
		
		gm=immultiply(area,g);  rm=r.*0;  bm=b.*0;
		color_filtered=cat(3,rm,gm,bm);
		if nargin == 3
			set(handles.axes3,'Visible','on');
			axes(handles.axes3);
			imshow(color_filtered);
		end

	elseif strcmp(color, 'yellow')
		color_filtered = yellow_filter(im);

		if nargin == 3
			set(handles.axes3,'Visible','on');
			axes(handles.axes3);
			imshow(color_filtered);
		end

	end
end

function red_filtered = red_filter(im)
	r=im(:,:,1); g=im(:,:,2); b=im(:,:,3);
	diff=imsubtract(r,rgb2gray(im));
	bw=im2bw(diff,0.18);
	area=bwareaopen(bw,300);
	rm=immultiply(area,r);  gm=g.*0;  bm=b.*0;
	red_filtered=cat(3,rm,gm,bm);
end

