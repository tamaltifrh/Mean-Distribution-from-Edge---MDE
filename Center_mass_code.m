



























% List all image files in the directory
Files = dir(fullfile(pwd,'*.tif')); % Change the file extension if needed

files={Files.name};
result_cell = {};

% Loop through each image file in the directory
for i = 1:length(files)

    % Load the image
    filename=char(files(i));
    %filename = fullfile(pwd, files(i).name);
    fprintf(1, 'Now reading %s\n', filename);
    imS = MicroscopeData.Original.ReadImages(pwd,filename); %import image series (multiple channels, and stacks)

    % Display the image and prompt user to select cell-edge ROI
    imagesc(imS(:,:,2)); colormap 'gray'
    title('Select cell boundary and press Enter');
    cell_roi = drawpolygon("Color",'blue');
    title('Select cell boundary and press Enter');
    cell_edge_roi = drawfreehand("Color",'red'); % Get freehand ROI from user input
    input('Press enter when done adjusting ROI objects');
    cell_edge_mask = createMask(cell_edge_roi);
    cell_edge_centroid = weight_centrd(cell_edge_mask,cell_edge_mask); %find cell edge center of mass
    [x1,y1] = ginput;
    %% Find organelle center of mass  
    
    %cell_mask = imS(:,:,3)>65281;
    cell_mask = createMask(cell_roi);
    imagesc(cell_mask);
    input('Press enter when done');
    %imshow(cell_mask);
    %cell_mask = 1-cell_mask;
    organelle_img = imS(:,:,1);
    %organelle_img1 = (1-cell_mask).*double(organelle_img);
    organelle_center = weight_centrd(cell_mask,organelle_img) ; 
     
    % Compute the distance between organelle center and edge center
    centroids = [cell_edge_centroid; organelle_center];
    centroids_edge = [[x1 y1]; organelle_center];
    dist_organelle = pdist(centroids,'euclidean');
    dist_organelle_edge = pdist(centroids_edge,'euclidean');
    imagesc(organelle_img);
    hold on;
    plot(organelle_center(1), organelle_center(2), 'r*', 'LineWidth', 2, 'MarkerSize', 16);
    plot(cell_edge_centroid(1), cell_edge_centroid(2), 'b*', 'LineWidth', 2, 'MarkerSize', 16);
    plot(x1, y1, 'g*', 'LineWidth', 2, 'MarkerSize', 16);
    input('Press enter when done');
    close()
    
    cell_area = sum(sum(cell_mask));
    avg_cell_radius = sqrt(cell_area/pi);
    result_cell{i,1} = filename;
    result_cell{i,2} = dist_organelle_edge;
    result_cell{i,3} = dist_organelle;
    result_cell{i,4} = dist_organelle_edge/avg_cell_radius;
    result_cell{i,5} = dist_organelle/avg_cell_radius;
    result_cell{i,6} = cell_area;
%
end
%%
result_table = cell2table(result_cell,'VariableNames',["filename", "dist_from_point", "dist_from_line", "norm_dist_from_point", "normalized_dist_from_line", "cell_area"])


