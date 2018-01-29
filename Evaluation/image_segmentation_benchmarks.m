%A MATLAB Toolbox
%
%Compare segmentation results with the Berkeley benchmark using four indices
%1. Probabilistic Rand Index
%2. Variation of Information
%3. Global Consistency Error
%4. Boundary Displacement Error
%
%The first three measures are calculated by the function compare_segmentations.m
%The last boundary measure is calculated by compare_image_boundary_error.m
%
%Please notice that this batch file is written to specifically compare the
%lossy coding results with the human segmentations in the Berkeley segbench database.
%
%As a result, the segbench human prior is resized to match the testset results.
%
%Authors: John Wright, and Allen Y. Yang
%Contact: Allen Y. Yang <yang@eecs.berkeley.edu>
%
%(c) Copyright. University of California, Berkeley. 2007.
%
%Notice: The packages should NOT be used for any commercial purposes
%without direct consent of their author(s). The authors are not responsible for any potential property loss or damage caused directly or indirectly by the usage of the software.
 
clear;
clc;

benchPath = '../../Dataset/Groundtruth_mat/';  %Ground truth
testPath = '../Canny/mat/'; %Segmentation result
cropBenchImage = true;

testImageList = dir(testPath);
if isempty(testImageList)
    error('Cannot find the image directories.');
end

averageBoundaryError = 0;
averageRI = 0;
averageVOI = 0;
averageGCE = 0;

imageCount = 0;
for imageIndex=1:length(testImageList)
    if testImageList(imageIndex).name(1)=='.'
        continue;
    end
    
    testFilename = [testPath testImageList(imageIndex).name];
    if ~strcmp(lower(testFilename(end-3:end)),'.mat')
        % Not a valid data file
        continue;
    end
    
    benchFilename = [benchPath testImageList(imageIndex).name];
    if isempty(dir(benchFilename))
        % The bench data for this image is not available
        warning(['Cannot find the bench file for ' testImageList(imageIndex).name]);
    end
    
    disp(['Processing ' testImageList(imageIndex).name]);
    load(benchFilename);
    load(testFilename);

    imageCount = imageCount + 1;
    imageLabel=groundTruth;
    
     %For gPb-owt-ucm
     
    %if exist('ucm2', 'var'),
   %ucm = double(ucm2);
   %clear ucm2;
   %elseif ~exist('segs', 'var')
    %error('unexpected input in inFile');
 %end
     
    %labels2 = bwlabel(ucm <= 0.4);
    %SegLabel = labels2(2:2:end, 2:2:end);

    sampleLabels = SegLabel; %meanshift+1

    % Comparison script
    totalBoundaryError = 0;
    sumRI = 0;
    sumVOI = 0;
    sumGCE = 0;

    [imageX, imageY] = size(sampleLabels);
    [benchX, benchY] = size(imageLabel);
    
    %for benchIndex=1:length(imageLabel)
        %benchLabels = imageLabel{benchIndex}.Segmentation;
            
        % update the four error measures:        
        totalBoundaryError = totalBoundaryError + compare_image_boundary_error(double(imageLabel),double(sampleLabels));
        [curRI,curGCE,curVOI] = compare_segmentations(double(sampleLabels),double(imageLabel));
        sumRI = sumRI + curRI;
        sumVOI = sumVOI + curVOI;
        sumGCE = sumGCE + curGCE;        
    
    
    % update the averages... note that sumRI / length(imageLabel) is
    % equivalent to the PRI.
    averageBoundaryError = averageBoundaryError + totalBoundaryError;
    averageRI = averageRI + sumRI;
    averageVOI = averageVOI + sumVOI;
    averageGCE = averageGCE + sumGCE;

    disp(['Current err:  Boundary  RI  VOI  GCE:']);
    disp([num2str(averageBoundaryError/imageCount) '  ' num2str(averageRI/imageCount) ...
         '  ' num2str(averageVOI/imageCount) '  ' num2str(averageGCE/imageCount)]);
end

averageBoundaryError = averageBoundaryError / imageCount
averageRI = averageRI / imageCount
averageGCE = averageGCE / imageCount
averageVOI = averageVOI / imageCount