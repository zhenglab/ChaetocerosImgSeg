clc;
clear all;
imgdir = './data/testset/'; 
fcndir = './features2/DeepLab-LargeFOV/val/fc8/';
outputdir = './temp/';

%cut results of DCNN

mkdir(outputdir);
inputPath = dir(imgdir);

for imgNum = 1:length(inputPath),
     if inputPath(imgNum).name(1)=='.'
            continue;
     end
    inputImgName = strcat(inputPath(imgNum).name);
    imgFile = strcat(imgdir,inputImgName);
    dataFile = [fcndir inputPath(imgNum).name(1:end-4) '_blob_0.mat'];
    outFile = [outputdir inputPath(imgNum).name(1:end-4) '_blob_0.mat'];

    dst=900;
    load(dataFile);
    image = imread(imgFile);
    [m, n, z] = size(image);
    if m ==dst && n == dst
        data = data(1:dst,1:dst,:);
    else
        data = data(1:n,1:m,:);
    end
    save(outFile,'data');    
end
        
