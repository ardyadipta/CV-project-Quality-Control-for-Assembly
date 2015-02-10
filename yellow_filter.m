function yellow_filtered = yellow_filter(im)
	[rows columns numberOfColorBands] = size(im); 
	% If it's monochrome (indexed), convert it to color. 
	% Check to see if it's an 8-bit image needed later for scaling).
	if strcmpi(class(im), 'uint8')
		% Flag for 256 gray levels.
		eightBit = true;
	else
		eightBit = false;
	end
	if numberOfColorBands == 1
		if isempty(storedColorMap)
			% Just a simple gray level image, not indexed with a stored color map.
			% Create a 3D true color image where we copy the monochrome image into all 3 (R, G, & B) color planes.
			im = cat(3, im, im, im);
		else
			% It's an indexed image.
			im = ind2rgb(im, storedColorMap);
			% ind2rgb() will convert it to double and normalize it to the range 0-1.
			% Convert back to uint8 in the range 0-255, if needed.
			if eightBit
				im = uint8(255 * im);
			end
		end
	end 
	

	% Convert RGB image to HSV
	hsvImage = rgb2hsv(im);
	% Extract out the H, S, and V images individually
	hImage = hsvImage(:,:,1);
	sImage = hsvImage(:,:,2);
	vImage = hsvImage(:,:,3);

	hueThresholdLow = 0;
	hueThresholdHigh = graythresh(hImage);
	saturationThresholdLow = graythresh(sImage);
	saturationThresholdHigh = 1.0;
	valueThresholdLow = graythresh(vImage);
	valueThresholdHigh = 1.0;

	% Now apply each color band's particular thresholds to the color band
	hueMask = (hImage >= hueThresholdLow) & (hImage <= hueThresholdHigh);
	saturationMask = (sImage >= saturationThresholdLow) & (sImage <= saturationThresholdHigh);
	valueMask = (vImage >= valueThresholdLow) & (vImage <= valueThresholdHigh);
	yellowObjectsMask = uint8(hueMask & saturationMask & valueMask);
	smallestAcceptableArea = 100; % Keep areas only if they're bigger than this.

	% Get rid of small objects.  Note: bwareaopen returns a logical.
	yellowObjectsMask = uint8(bwareaopen(yellowObjectsMask, smallestAcceptableArea));


	% Smooth the border using a morphological closing operation, imclose().
	structuringElement = strel('disk', 4);
	yellowObjectsMask = imclose(yellowObjectsMask, structuringElement);

	% Fill in any holes in the regions, since they are most likely red also.
	yellowObjectsMask = uint8(imfill(yellowObjectsMask, 'holes'));


	% You can only multiply integers if they are of the same type.
	% (yellowObjectsMask is a logical array.)
	% We need to convert the type of yellowObjectsMask to the same data type as hImage.
	yellowObjectsMask = cast(yellowObjectsMask, class(im)); 

	% Use the yellow object mask to mask out the yellow-only portions of the rgb image.
	maskedImageR = yellowObjectsMask .* im(:,:,1);
	maskedImageG = yellowObjectsMask .* im(:,:,2);
	maskedImageB = yellowObjectsMask .* im(:,:,3);

	yellow_filtered = cat(3, maskedImageR, maskedImageG, maskedImageB);
end