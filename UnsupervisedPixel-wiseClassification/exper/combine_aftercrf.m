clc;
clear all;
addpath my_script;
inputdir = './res/DeepLab-LargeFOV/val/';
imgdir = './finalresult/';
%merge small images
mkdir(imgdir);

loal_Folder=fullfile(inputdir);
dirOutput=dir(fullfile(loal_Folder,'*.bin'));
fileNames={dirOutput.name};
[c,num] = size(fileNames);
h = 0;
w = 0;
k=1;
while k<=num
    img = [];
    if k~=num
        for t=0:100
            if k+t+1==num
                temp = fileNames{k+t+1}(end:-1:1);
                h = str2num(temp(7));
                w = str2num(temp(5));
                break
            end
            
            if strcmp(fileNames{k+t}(1:end-8),fileNames{k+t+1}(1:end-8))
                temp = fileNames{k+t+1}(end:-1:1);
                h = str2num(temp(7));
                w = str2num(temp(5));
            else 
                break;
            end
            
        end
        for i=1:h
            temp1 = [];
            for j=1:w
                data = LoadBinFile([loal_Folder,fileNames{k+t}(1:end-7),num2str(i),'_',num2str(j),'.bin'],'int16');
                temp1 = [temp1,data];
            end
            img = [img;temp1];
        end
        img = mat2gray(img);
        imgfile = [imgdir fileNames{k}(1:end-8),'.png'];
        imwrite(img,imgfile);   
    end 
    k=k+w*h;
end
