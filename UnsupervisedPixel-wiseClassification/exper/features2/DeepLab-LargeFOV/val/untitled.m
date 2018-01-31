%3D


clear all;
Files =  dir(strcat('./','*.mat'));
LengthFiles = length(Files);

for i = 1:LengthFiles
load(strcat('./',Files(i).name));
%data = data.data;
%%[a,local] = max(data,[],3);
%imshow(local,[]);
data = data(:,end:-1:1,:);
data = imrotate(data,90);
save(strcat('../fc8mat/',Files(i).name),'data');
%image = mat2gray(data);
%Imagename = strcat(Files(i).name(1:(end-4)),'.png');
%imwrite(image,strcat('../fc8img/',Imagename));
end


fid = fopen('2007_000129.bin', 'rb');
row = fread(fid, 1, 'int32');
col = fread(fid, 1, 'int32');
channel = fread(fid, 1, 'int32');
num_ele = row*col*channel;
out = fread(fid, num_ele, 'uint16'); 
out = reshape(out, [row, col, channel]);
imshow(out,[]);