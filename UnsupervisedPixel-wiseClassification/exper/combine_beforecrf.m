clc;
clear all;
inputdir = './temp/';
outputdir = './beforecrf/';
imgdir = './imgresult/';
%merge small images


mkdir(outputdir);
mkdir(imgdir);

loal_Folder=fullfile(inputdir);
dirOutput=dir(fullfile(loal_Folder,'*.mat'));
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
                h = str2num(temp(14));
                w = str2num(temp(12));
                break
            end
            
            if strcmp(fileNames{k+t}(1:end-15),fileNames{k+t+1}(1:end-15))
                temp = fileNames{k+t+1}(end:-1:1);
                h = str2num(temp(14));
                w = str2num(temp(12));
            else 
                break;
            end
            
        end
        for i=1:h
            temp1 = [];
            for j=1:w
                load([loal_Folder,fileNames{k+t}(1:end-14),num2str(i),'_',num2str(j),'_blob_0.mat']);
                temp1 = [temp1,data];
            end
            img = [img;temp1];
        end
        data = img;
        outfile = [outputdir fileNames{k}(1:end-15),'_blob_0.mat'];
        imgfile = [imgdir fileNames{k}(1:end-15),'.png'];
        save(outfile,'data'); 
        [a,local] = max(data,[],3);    
        local = mat2gray(local);
        imwrite(local,imgfile);   
    end 
    k=k+w*h;
end

