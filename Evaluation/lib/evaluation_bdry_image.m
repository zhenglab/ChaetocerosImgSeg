function [cntR,sumR,cntP,sumP] = evaluation_bdry_image(inFile,gtFile, prFile, maxDist, thinpb)
% [thresh,cntR,sumR,cntP,sumP] = boundaryPR_image(inFile,gtFile, prFile, nthresh, maxDist, thinpb)
%
% Calculate precision/recall curve.
%
% INPUT
%	inFile  : Can be one of the following:
%             - a soft or hard boundary map in image format.
%             - a collection of segmentations in a cell 'segs' stored in a mat file
%             - an ultrametric contour map in 'doubleSize' format, 'ucm2'
%               stored in a mat file with values in [0 1].
%
%	gtFile	: File containing a cell of ground truth boundaries
%   prFile  : Temporary output for this image.
%	nthresh	: Number of points in PR curve.
%   MaxDist : For computing Precision / Recall.
%   thinpb  : option to apply morphological thinning on segmentation
%             boundaries.
%
% OUTPUT
%	thresh		Vector of threshold values.
%	cntR,sumR	Ratio gives recall.
%	cntP,sumP	Ratio gives precision.
%
if nargin<6, thinpb = 1; end
if nargin<5, maxDist = 0.0075; end

[p,n,e]=fileparts(inFile);
if strcmp(e,'.mat'),
    load(inFile);
end

pb = double(imgLabel);
%if exist('ucm2', 'var'),
%    pb = double(ucm2(3:2:end, 3:2:end));
%    clear ucm2;
%elseif ~exist('segs', 'var')
%    pb = double(imread(inFile))/255;
%end


load(gtFile);
if isempty(groundTruth),
    error(' bad gtFile !');
end

% zero all counts
cntR = 0;
sumR = 0;
cntP = 0;
sumP = 0;

 bmap = logical(seg2bdry(pb,'imageSize'));
%if ~exist('segs', 'var')
%   bmap = (pb>=0.4);
%else
%    bmap = logical(seg2bdry(segs,'imageSize'));
%end
    
    % thin the thresholded pb to make sure boundaries are standard thickness
    if thinpb,
        bmap = double(bwmorph(bmap, 'thin', inf));    % OJO
    end
    
    % accumulate machine matches, since the machine pixels are
    % allowed to match with any segmentation
    accP = zeros(size(bmap));
    
    % compare to each seg in turn
    %for i = 1:numel(groundTruth),
        % compute the correspondence
        [match1,match2] = correspondPixels(bmap, double(groundTruth), maxDist);
        % accumulate machine matches
        accP = accP | match1;
        % compute recall
        sumR = sumR + sum(groundTruth(:));
        cntR = cntR + sum(match2(:)>0);
    %end
    
    % compute precision
    sumP = sumP + sum(bmap(:));
    cntP = cntP + sum(accP(:));



% output
fid = fopen(prFile,'w');2
if fid==-1,
    error('Could not open file %s for writing.', prFile);
end
fprintf(fid,'%10g %10g %10g %10g\n',[cntR sumR cntP sumP]');
fclose(fid);

