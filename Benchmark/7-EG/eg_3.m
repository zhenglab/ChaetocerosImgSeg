clear all;close all;clc;

imgDir = './result';
outDir= './mat';
mkdir(outDir);
D= dir(fullfile(imgDir,'*.png'));

for i =1:numel(D),
    outFile = fullfile(outDir,[D(i).name(1:end-4) '.mat']);
    if exist(outFile,'file'), continue; end
    imgFile = fullfile(imgDir,D(i).name);
    I = imread(imgFile);
    %your code here
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x,y,z] = size(I);
    if z == 3, I = rgb2gray(I);end
    num = x*y;
    max = 0;
    for i = 1:num,
      f = find(I == i);
      if max < length(f)
       max=length(f);
       label=i;
      end
    end 
    L(find(L == label))=0;
    imgLabel=bwlabel(I);
    save(outFile,'SegLabel');
    
end
