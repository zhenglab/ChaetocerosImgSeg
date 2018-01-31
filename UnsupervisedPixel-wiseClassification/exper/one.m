clear all;
addpath my_script;


load('聚生角毛藻02_1_1_blob_0.mat')
[a,local] = max(data,[],3);       
local = mat2gray(local);
imwrite(local,'imgresult/聚生角毛藻02.png');

data=LoadBinFile('聚生角毛藻02_1_1.bin','int16');
data=mat2gray(data);
imwrite(local,'finalresult/聚生角毛藻02.png');

