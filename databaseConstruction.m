function databaseConstruction()
%
% Flow:
%     1. Resize images
%     2. Blur images
%     3. Convert images to images of HSV color model
%     4. Quantize the hue(H) component of images
%     5. Calculate the hue-histogram has the feature vector for an iamge
%     6. Store the hue-histograms of all images in a binary file
%

% Get path to image set from user
inputPath = '.\Images\class-11';
%inputPath = input('Enter the path to the image set (the set of the sample images): ', 's');
% while isempty(dir(inputPath)) == 1 || isdir(inputPath) == 0
%     disp('Invalid Path!');
%     break
%     inputPath = input('Enter the path to the image set (the set of the sample images): ', 's');
% end
if inputPath(length(inputPath)) ~= '\'
    inputPath = strcat(inputPath, '\');
end

% Create a folder to hold the newly constructed database
%mkdir('.\Database');
cd('E:\Renish\Database\');

% Database data
rgbHiss = zeros(216, 2, 100);

list = dir(inputPath);
for j = 1 : length(list)
   if ~isempty(findstr(list(i).name, 'jpg'))
       fileName = strcat(inputPath, list(i).name);
       
       % Read an image
       img = imread(fileName);
       
       % Change it to HSV domain
       qImg = quantizeRGB(img, 6);
       % Get the index of the image
       [token, remain] = strtok(list(j).name, '.');
      
       rgbHiss(:, :, str2double(token) + 1) = computeRGBHis(qImg, 216);
   end
end

% Write the database data to a binary file for future use

fid = fopen('class-11.bin', 'w');
for k = 1 : 100
    fwrite(fid, rgbHiss(:, :, k), 'double');
end
fclose(fid);
end