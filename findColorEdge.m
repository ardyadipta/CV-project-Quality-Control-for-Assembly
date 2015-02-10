function color_edges = findColorEdge(color_filtered)
	color_edges = zeros(size(color_filtered));
	i = 1;
	j = 1;

	%first, find edge from black to object
		while (i < size(color_filtered, 1))
			while (j < size(color_filtered, 2))
				if ~any(color_filtered(i,j,:)) & (any(color_filtered(i, j+1, :))) %edge found from black to object
					color_edges(i,j+1,:) = color_filtered(i,j+1,:);
				end

				if any(color_filtered(i,j,:)) & (~any(color_filtered(i, j+1, :))) %edge found from object to black
					color_edges(i,j,:) = color_filtered(i,j,:);
				end

				j = j+1;
				
			end

			i = i+1;
		end

					


end
