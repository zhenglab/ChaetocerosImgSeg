function regionBench(imgDir, gtDir, inDir, outDir)
% regionBench(imgDir, gtDir, inDir, outDir, nthresh)
%
% Run region benchmarks on dataset: Probabilistic Rand Index, Variation of
% Information and Segmentation Covering. 
%
% INPUT
%   imgDir: folder containing original images
%   gtDir:  folder containing ground truth data.
%   inDir:  folder containing segmentation results for all the images in imgDir. 
%           Format can be one of the following:
%             - a collection of segmentations in a cell 'segs' stored in a mat file
%             - an ultrametric contour map in 'doubleSize' format, 'ucm2' stored in a mat file with values in [0 1].
%   outDir: folder where evaluation results will be stored
%
% Pablo Arbelaez <arbelaez@eecs.berkeley.edu>


iids = dir(fullfile(imgDir,'*.png'));
for i = 1 : numel(iids),
    inFile = fullfile(inDir, strcat(iids(i).name(1:end-4), '.mat'));
    gtFile = fullfile(gtDir, strcat(iids(i).name(1:end-4), '.mat'));
    evFile2 = fullfile(outDir, strcat(iids(i).name(1:end-4), '_ev2.txt'));
   
    evaluation_reg_image(inFile, gtFile, evFile2);
  
    disp(i);
end

%% collect results
collect_eval_reg(outDir);

%% clean up
%delete(sprintf('%s/*_ev2.txt', outDir));
%delete(sprintf('%s/*_ev3.txt', outDir));
%delete(sprintf('%s/*_ev4.txt', outDir));



