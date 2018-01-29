function [ bestF, bestP, bestR, bestT, F_max, P_max, R_max, Area_PR] = collect_eval_bdry(pbDir)
% function [ bestF, bestP, bestR, bestT, F_max, P_max, R_max, Area_PR ] = collect_eval_bdry(pbDir)
%
% calculate P, R and F-measure from individual evaluation files
%
% Pablo Arbelaez <arbelaez@eecs.berkeley.edu>


fname = fullfile(pbDir, 'eval_bdry.txt');
S = dir(fullfile(pbDir,'*_ev1.txt'));
filename = fullfile(pbDir,S(1).name);
AA = dlmread(filename); %cntR sumR cntP sumP
F_total = 0;
    
for i = 1:length(S),
    
        iid = S(i).name(1:end-8);
        fprintf(2,'Processing image %s (%d/%d)...\n',iid,i,length(S));

        filename = fullfile(pbDir,S(i).name);
        AA  = dlmread(filename);
        cntR = AA(:, 1);
        sumR = AA(:, 2);
        cntP = AA(:, 3);
        sumP = AA(:, 4);

        R = cntR ./ (sumR + (sumR==0));
        P = cntP ./ (sumP + (sumP==0));
        F = fmeasure(R,P);
        F_total = F_total + F;
        
end
fname = fullfile(pbDir,'eval_bdry.txt');
fid = fopen(fname,'w');
if fid==-1,
   error('Could not open file %s for writing.',fname);
end
fprintf(fid,'%10g\n',F_total);
fclose(fid);

    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute f-measure fromm recall and precision
function [f] = fmeasure(r,p)
f = 2*p.*r./(p+r+((p+r)==0));