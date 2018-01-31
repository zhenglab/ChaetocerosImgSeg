clear all;
Files =  dir(strcat('./temp/','*.mat'));
LengthFiles = length(Files);

for i = 1:LengthFiles
load(strcat('./temp/',Files(i).name));
%data = data.data;
%%[a,local] = max(data,[],3);
%imshow(local,[]);
data = data(:,end:-1:1,:);
data = imrotate(data,90);
save(strcat('./temp/',Files(i).name),'data');
%image = mat2gray(data);
%Imagename = strcat(Files(i).name(1:(end-4)),'.png');
%imwrite(image,strcat('../fc8img/',Imagename));
end