function [cntR, sumR, cntP, sumP] = evaluation_reg_image(inFile, gtFile, evFile2)
% function [thresh, cntR, sumR, cntP, sumP, cntR_best] = evaluation_reg_image(inFile, gtFile, evFile2, evFile3, evFile4, nthresh)
%
% Calculate region benchmarks for an image. Probabilistic Rand Index, Variation of
% Information and Segmentation Covering. 
%
% INPUT
%	inFile  : Can be one of the following:
%             - a collection of segmentations in a cell 'segs' stored in a mat file
%             - an ultrametric contour map in 'doubleSize' format, 'ucm2'
%               stored in a mat file with values in [0 1].
%
%	gtFile	:   File containing a cell of ground truth segmentations
%   evFile2 : Temporary output for this image.
%
%
% OUTPUT
%	cntR,sumR	Ratio gives recall.
%	cntP,sumP	Ratio gives precision.
%
%
% Pablo Arbelaez <arbelaez@eecs.berkeley.edu>


load(inFile); 
%if exist('ucm2', 'var'),
%    ucm = double(ucm2);
%    clear ucm2;
%elseif ~exist('segs', 'var')
%    error('unexpected input in inFile');
%end

load(gtFile);


regionsGT = [];
total_gt = 0;

groundTruth = double(groundTruth);
regionsTmp = regionprops(groundTruth, 'Area');
regionsGT = [regionsGT; regionsTmp];
total_gt = total_gt + max(groundTruth(:));

% zero all counts
cntR = 0;
sumR = 0;
cntP = 0;
sumP = 0;

best_matchesGT = zeros(1, total_gt);


%labels2 = bwlabel(ucm <= 0.4);
%seg = labels2(2:2:end, 2:2:end); ％gpb才用
seg = SegLabel; %几种算法中只有meanshift需要加1，其余不加
    
[matches] = match_segmentations(seg, groundTruth);
matchesSeg = max(matches, [], 2);
matchesGT = max(matches, [], 1);
     
regionsSeg = regionprops(seg, 'Area');
for r = 1 : numel(regionsSeg)
    cntP = cntP+ regionsSeg(r).Area*matchesSeg(r);
    sumP = sumP + regionsSeg(r).Area;
end
    
for r = 1 : numel(regionsGT),
    cntR = cntR +  regionsGT(r).Area*matchesGT(r);
    sumR = sumR + regionsGT(r).Area;
end
    
fid = fopen(evFile2, 'w');
if fid == -1, 
    error('Could not open file %s for writing.', evFile2);
end
fprintf(fid,'%10g %10g %10g %10g\n',[cntR, sumR, cntP, sumP]');
fclose(fid);




