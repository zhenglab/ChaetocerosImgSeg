function Fmax = ComputeFMeasure(seg,groundtruth)
%Compute the F-score for a single segment
%Syntax:
%       [Results]=ComputeFMeasure(DBpath,SegResultsSubPath,SysType)
%Input:
%       DBpath - The directory of the entire evaluation Database
%       SegResultsSubPath - The name of the sub-directory  in which the results of
%                           the algorithm to be evaluated  are placed.
%       SysType - The type of system in use, this determines the path
%       separation char.There are two optional values 'win' or 'unix' if no value is
%                 specified the default is set to 'win'.
%Output:
%       Results - An 100X3 matrix where Results(i,1) holds the best F-score for a single segment.
%                 Results(i,2) and Results(i,3) holds the corresponding Recall and Precision scores.
%       Example:
%                 [Results]=ComputeFMeasure('c:\Evaluation_DB','MyRes','pc');
%
%The evaluation function is given as is without any warranty. The Weizmann
%institute of science is not liable for any damage, lawsuits, 
%or other loss resulting from the use of the evaluation functions.
%Written by Sharon Alpert Department of Computer Science and Applied Mathematics
%The Weizmann Institute of Science 2007

Results=zeros(1,3);
[Pmax Rmax Fmax]=CalcCandScore(seg,groundtruth);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Calcuate the F-score                                     %
%%%%%%%%%%%%%%%%%%%гн%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p r f]=CalcPRPixel(GT,mask)
    if (sum(GT(:)&mask(:))==0)
        p=0;r=0;f=0; 
        return;
    end;
    r=sum(GT(:)&mask(:))./sum(GT(:));
    c=sum(mask(:))-sum(GT(:)&mask(:));
    p=sum(GT(:)&mask(:))./(sum(GT(:)&mask(:))+c);
    f=(r*p)/(0.5*(r+p));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Calcuate the F-score of the evaluated method             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Pmax Rmax Fmax]=CalcCandScore(seg,groundtruth)

Fmax=0;
Pmax=0;
Rmax=0;

Segmap=seg;
NumOfSegs=unique(Segmap(:)); %find out how many segments
   
for j=1:length(NumOfSegs)
    t=(Segmap==NumOfSegs(j));
    if sum(t(:))<=5 continue;end; %skip small segments
    [p r f]=CalcPRPixel(t,groundtruth);
    if (f>Fmax)
        Fmax=f;
        Pmax=p;
        Rmax=r;
    end;
end