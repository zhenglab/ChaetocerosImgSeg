clear all;
Files =  dir(strcat('./fc8/','*.mat'));
LengthFiles = length(Files);

for i = 1:LengthFiles
load(strcat('./fc8/',Files(i).name));
front = data(:,:,2);
max_ = max(max(max(data)));
min_ = min(min(min(data)));
front_zf = (front-min_)/(max_-min_);
data = front_zf>=0.45;
data = uint8(data);
save(strcat('./fc8a/',Files(i).name),'data');
end