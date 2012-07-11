% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

%% For figuring out the conditions...
% stim = rev_phi_phase_delay_4_wide_v01;
% cond_num = n;
% disp(cond_num)
% disp(stim(cond_num).PosFuncNameX(19:end))
% disp(stim(cond_num).PosFuncNameY(19:end))

%%
sym_conditions = ...
                       {[001,018];... % 1 Hz 62.5 bef
                        [002,019];... % 52.5 bef
                        [003,020];... % 45 bef
                        [004,021];... % 35 aft
                        [005,022];... % 27 aft
                        [006,023];... % 20 bef
                        [007,024];... % 10 aft
                        [008,025];... % 2.5 bef
                        [009,026];... % 0
                        [010,027];... % 2.5 aft
                        [011,028];... % 12.5 bef
                        [012,029];... % 20 aft
                        [013,030];... % 30 bef
                        [014,031];... % 37.5 bef
                        [015,032];... % 45 aft
                        [016,033];... % 55 bef
                        [017,034];... % 1 Hz 62.5 aft
                        [035,052];... % 2 Hz 32.5 bef
                        [036,053];... % 27.5 aft
                        [037,054];... % 22.5 aft
                        [038,055];... % 20 bef
                        [039,056];... % 15 bef
                        [040,057];... % 10 aft
                        [041,058];... % 5 aft
                        [042,059];... % 2.5 bef
                        [043,060];... % 0
                        [044,061];... % 2.5 aft
                        [045,062];... % 7.5 bef
                        [046,063];... % 12.5 bef
                        [047,064];... % 15 aft
                        [048,065];... % 20 aft
                        [049,066];... % 25 bef
                        [050,067];... % 30 bef
                        [051,068];... % 2 Hz 32.5 aft
                        [069,086];... % 3 Hz 20 bef
                        [070,087];... % 17.5 bef
                        [071,088];... % 15 bef
                        [072,089];... % 12.5 bef
                        [073,090];... % 10 bef
                        [074,091];... % 7.5 bef
                        [075,092];... % 5 bef
                        [076,093];... % 2.5 bef
                        [077,094];... % 0
                        [078,095];... % 2.5 aft
                        [079,096];... % 5 aft
                        [080,097];... % 7.5 aft
                        [081,098];... % 10 aft
                        [082,099];... % 12.5 aft
                        [083,100];... % 15 aft
                        [084,101];... % 17.5 aft
                        [085,102]};   % 3 Hz 20 aft

grouped_conditions{1}.name = '1 Hz';
grouped_conditions{1}.tf = 1;
grouped_conditions{1}.x_axis = [-62.5 -55 -52.5 -45 -37.5 -30 -20 -12.5 -2.5 0 2.5 10 20 27 35 45 62.5];
grouped_conditions{1}.list = ...
                       {[001,018];... % 1 Hz 62.5 bef
                        [016,033];... % 55 bef                       
                        [002,019];... % 52.5 bef
                        [003,020];... % 45 bef
                        [014,031];... % 37.5 bef  
                        [013,030];... % 30 bef                        
                        [006,023];... % 20 bef
                        [011,028];... % 12.5 bef                        
                        [008,025];... % 2.5 bef
                        [009,026];... % 0
                        [010,027];... % 2.5 aft
                        [007,024];... % 10 aft                        
                        [012,029];... % 20 aft
                        [005,022];... % 27 aft
                        [004,021];... % 35 aft                        
                        [015,032];... % 45 aft
                        [017,034]};   % 1 Hz 62.5 aft                    

grouped_conditions{2}.name = '2 Hz';
grouped_conditions{2}.tf = 2;
grouped_conditions{2}.x_axis = [-32.5 -30 -25 -20 -15 -12.5 -7.5 -2.5 0 2.5 5 10 15 20 22.5 27.5 32.5];
grouped_conditions{2}.list = ...
                       {[035,052];... % 2 Hz 32.5 bef
                        [050,067];... % 30 bef                       
                        [049,066];... % 25 bef                       
                        [038,055];... % 20 bef
                        [039,056];... % 15 bef
                        [046,063];... % 12.5 bef                        
                        [045,062];... % 7.5 bef
                        [042,059];... % 2.5 bef
                        [043,060];... % 0
                        [044,061];... % 2.5 aft
                        [041,058];... % 5 aft
                        [040,057];... % 10 aft
                        [047,064];... % 15 aft
                        [048,065];... % 20 aft
                        [037,054];... % 22.5 aft
                        [036,053];... % 27.5 aft
                        [051,068]};   % 2 Hz 32.5 aft
                    
                        
grouped_conditions{3}.name = '3 Hz';
grouped_conditions{3}.tf = 3;
grouped_conditions{3}.x_axis = [-20 -17.5 -15 -12.5 -10 -7.5 -5 -2.5 0 2.5 5 7.5 10 12.5 15 17.5 20];
grouped_conditions{3}.list = ...
                       {[069,086];... % 3 Hz 20 bef
                        [070,087];... % 17.5 bef
                        [071,088];... % 15 bef
                        [072,089];... % 12.5 bef
                        [073,090];... % 10 bef
                        [074,091];... % 7.5 bef
                        [075,092];... % 5 bef
                        [076,093];... % 2.5 bef
                        [077,094];... % 0
                        [078,095];... % 2.5 aft
                        [079,096];... % 5 aft
                        [080,097];... % 7.5 aft
                        [081,098];... % 10 aft
                        [082,099];... % 12.5 aft
                        [083,100];... % 15 aft
                        [084,101];... % 17.5 aft
                        [085,102]};   % 3 Hz 20 aft
