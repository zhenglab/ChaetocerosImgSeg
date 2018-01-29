function collect_eval_reg(ucmDir)
% Pablo Arbelaez <arbelaez@eecs.berkeley.edu>

fname = fullfile(ucmDir, 'eval_cover.txt');
if (length(dir(fname))~=1),
    
    S = dir(fullfile(ucmDir,'*_ev2.txt'));
 
    R_total = 0;
    P_total = 0;
    
    for i = 1:numel(S),
        
        iid = S(i).name(1:end-8);
        fprintf(2,'Processing image %s (%d/%d)...\n',iid,i,length(S));
        
        evFile1 = fullfile(ucmDir,S(i).name);
        tmp  = dlmread(evFile1);
        cntR = tmp(:, 1);
        sumR = tmp(:, 2);
        cntP = tmp(:, 3);
        sumP = tmp(:, 4);
        
        R = cntR ./ (sumR + (sumR==0));
        P = cntP ./ (sumP + (sumP==0));
        R_total = R_total + R;
        P_total = P_total + P;
    end
    
    R = R_total / numel(S);
    P = P_total / numel(S);
     
end


fid = fopen(fname,'w');
if fid == -1
   error('Could not open file %s for writing.',fname);
end;
fprintf(fid,'%10g %10g\n',R, P);
fclose(fid);


