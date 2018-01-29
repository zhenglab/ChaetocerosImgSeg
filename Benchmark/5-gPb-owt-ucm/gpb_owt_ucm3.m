addpath lib;

clear all;close all;clc;

imgDir = './mat';
outDir1 = './final_bdry';
outDir2 = './result';
mkdir(outDir1);
mkdir(outDir2);
D= dir(fullfile(imgDir,'*.mat'));

tic;
for i =1:numel(D),
    outFile1 = fullfile(outDir1,[D(i).name(1:end-4) '.png']);
    outFile2=fullfile(outDir2,[D(i).name(1:end-4) '.png']);
    imgFile=fullfile(imgDir,D(i).name);
    load(imgFile,'ucm2');
    ucm = ucm2(3:2:end, 3:2:end);
    
    k = 0.3;
    bdry = (ucm >= k);
    imwrite(bdry,outFile1);
    labels2 = bwlabel(ucm2 <= k);
    labels = labels2(2:2:end, 2:2:end);
    result = mat2gray(labels);  %??double????????????????????
    %imshow(labels,[]);colormap(jet);
    %labels=label2rgb(labels);
    imwrite(result,outFile2); 
end
toc;
