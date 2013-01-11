%% Grouped conditions file, specifies which conditions belong together in
% the form:
% Grouped conditions, cond2/4 = transformed to cond1/3, form below
% {[cond1_rep1... cond1_repN], [cond2_rep1... cond2_repN]; 
% [cond3_rep1... cond3_repN], [cond4_rep1... cond4_repN]}
%
% This file is used to hopefully automate comparisons later on

% For unilateral stimuli (all in terms of cw!):
% ccw_left(-) and cw_right(+)  go together -- progressive!!!!
% cw_left(+)  and ccw_right(-) go together -- regressive!!!!!
sym_conditions = [];

grouped_conditions{1}.name = 'Progressive: Left-\lambda 15, Right-\lambda 15';
grouped_conditions{1}.tf = [.5 4 8];
grouped_conditions{1}.motion = 'progressive';
grouped_conditions{1}.speed = [.5 4 8]*4;
grouped_conditions{1}.list = {1,...
                              17,...
                              33};

grouped_conditions{2}.name = 'Progressive: Left-\lambda 30, Right-\lambda 15';
grouped_conditions{2}.tf = [.5 4 8];
grouped_conditions{2}.motion = 'progressive';
grouped_conditions{2}.speed = [.5 4 8]*4;
grouped_conditions{2}.list = {2,...
                              18,...
                              34};

grouped_conditions{3}.name = 'Progressive: Left-\lambda 60, Right-\lambda 15';
grouped_conditions{3}.tf = [.5 4 8];
grouped_conditions{3}.motion = 'progressive';
grouped_conditions{3}.speed = [.5 4 8]*4;
grouped_conditions{3}.list = {3,...
                              19,...
                              35};
                          
grouped_conditions{4}.name = 'Progressive: Left-\lambda 90, Right-\lambda 15';
grouped_conditions{4}.tf = [.5 4 8];
grouped_conditions{4}.motion = 'progressive';
grouped_conditions{4}.speed = [.5 4 8]*4;
grouped_conditions{4}.list = {4,...
                              20,...
                              36};
                          
grouped_conditions{5}.name = 'Progressive: Left-\lambda 15, Right-\lambda 30';
grouped_conditions{5}.tf = [.5 4 8];
grouped_conditions{5}.motion = 'progressive';
grouped_conditions{5}.speed = [.5 4 8]*4;
grouped_conditions{5}.list = {5,...
                              21,...
                              37};
                          
grouped_conditions{6}.name = 'Progressive: Left-\lambda 30, Right-\lambda 30';
grouped_conditions{6}.tf = [.5 4 8];
grouped_conditions{6}.motion = 'progressive';
grouped_conditions{6}.speed = [.5 4 8]*4;
grouped_conditions{6}.list = {6,...
                              22,...
                              38};
                          
grouped_conditions{7}.name = 'Progressive: Left-\lambda 60, Right-\lambda 30';
grouped_conditions{7}.tf = [.5 4 8];
grouped_conditions{7}.motion = 'progressive';
grouped_conditions{7}.speed = [.5 4 8]*4;
grouped_conditions{7}.list = {7,...
                              23,...
                              39};

grouped_conditions{8}.name = 'Progressive: Left-\lambda 90, Right-\lambda 30';
grouped_conditions{8}.tf = [.5 4 8];
grouped_conditions{8}.motion = 'progressive';
grouped_conditions{8}.speed = [.5 4 8]*4;
grouped_conditions{8}.list = {8,...
                              24,...
                              40};
                          
grouped_conditions{9}.name = 'Progressive: Left-\lambda 15, Right-\lambda 60';
grouped_conditions{9}.tf = [.5 4 8];
grouped_conditions{9}.motion = 'progressive';
grouped_conditions{9}.speed = [.5 4 8]*4;
grouped_conditions{9}.list = {9,...
                              25,...
                              41};
                          
grouped_conditions{10}.name = 'Progressive: Left-\lambda 30, Right-\lambda 60';
grouped_conditions{10}.tf = [.5 4 8];
grouped_conditions{10}.motion = 'progressive';
grouped_conditions{10}.speed = [.5 4 8]*4;
grouped_conditions{10}.list = {10,...
                              26,...
                              42};
                          
grouped_conditions{11}.name = 'Progressive: Left-\lambda 60, Right-\lambda 60';
grouped_conditions{11}.tf = [.5 4 8];
grouped_conditions{11}.motion = 'progressive';
grouped_conditions{11}.speed = [.5 4 8]*4;
grouped_conditions{11}.list = {11,...
                              27,...
                              43};
                          
grouped_conditions{12}.name = 'Progressive: Left-\lambda 90, Right-\lambda 60';
grouped_conditions{12}.tf = [.5 4 8];
grouped_conditions{12}.motion = 'progressive';
grouped_conditions{12}.speed = [.5 4 8]*4;
grouped_conditions{12}.list = {12,...
                              28,...
                              44};
                          
grouped_conditions{13}.name = 'Progressive: Left-\lambda 15, Right-\lambda 90';
grouped_conditions{13}.tf = [.5 4 8];
grouped_conditions{13}.motion = 'progressive';
grouped_conditions{13}.speed = [.5 4 8]*4;
grouped_conditions{13}.list = {13,...
                              29,...
                              45};
                          
grouped_conditions{14}.name = 'Progressive: Left-\lambda 30, Right-\lambda 90';
grouped_conditions{14}.tf = [.5 4 8];
grouped_conditions{14}.motion = 'progressive';
grouped_conditions{14}.speed = [.5 4 8]*4;
grouped_conditions{14}.list = {14,...
                              30,...
                              46};
                          
grouped_conditions{15}.name = 'Progressive: Left-\lambda 60, Right-\lambda 90';
grouped_conditions{15}.tf = [.5 4 8];
grouped_conditions{15}.motion = 'progressive';
grouped_conditions{15}.speed = [.5 4 8]*4;
grouped_conditions{15}.list = {15,...
                              31,...
                              47};                
                          
grouped_conditions{16}.name = 'Progressive: Left-\lambda 90, Right-\lambda 90';
grouped_conditions{16}.tf = [.5 4 8];
grouped_conditions{16}.motion = 'progressive';
grouped_conditions{16}.speed = [.5 4 8]*4;
grouped_conditions{16}.list = {16,...
                              32,...
                              48};                
                          
grouped_conditions{17}.name = 'Regressive: Left-\lambda 15, Right-\lambda 15';
grouped_conditions{17}.tf = [.5 4 8];
grouped_conditions{17}.motion = 'regressive';
grouped_conditions{17}.speed = [.5 4 8]*4;
grouped_conditions{17}.list = {49,...
                              65,...
                              81};         
                          
grouped_conditions{18}.name = 'Regressive: Left-\lambda 30, Right-\lambda 15';
grouped_conditions{18}.tf = [.5 4 8];
grouped_conditions{18}.motion = 'regressive';
grouped_conditions{18}.speed = [.5 4 8]*4;
grouped_conditions{18}.list = {50,...
                              66,...
                              82};         
                          
grouped_conditions{19}.name = 'Regressive: Left-\lambda 60, Right-\lambda 15';
grouped_conditions{19}.tf = [.5 4 8];
grouped_conditions{19}.motion = 'regressive';
grouped_conditions{19}.speed = [.5 4 8]*4;
grouped_conditions{19}.list = {51,...
                              67,...
                              83};         
                          
grouped_conditions{20}.name = 'Regressive: Left-\lambda 90, Right-\lambda 15';
grouped_conditions{20}.tf = [.5 4 8];
grouped_conditions{20}.motion = 'regressive';
grouped_conditions{20}.speed = [.5 4 8]*4;
grouped_conditions{20}.list = {52,...
                              68,...
                              84};         
                          
grouped_conditions{21}.name = 'Regressive: Left-\lambda 15, Right-\lambda 30';
grouped_conditions{21}.tf = [.5 4 8];
grouped_conditions{21}.motion = 'regressive';
grouped_conditions{21}.speed = [.5 4 8]*4;
grouped_conditions{21}.list = {53,...
                              69,...
                              85};         
                          
grouped_conditions{22}.name = 'Regressive: Left-\lambda 30, Right-\lambda 30';
grouped_conditions{22}.tf = [.5 4 8];
grouped_conditions{22}.motion = 'regressive';
grouped_conditions{22}.speed = [.5 4 8]*4;
grouped_conditions{22}.list = {54,...
                              70,...
                              86};         
                          
grouped_conditions{23}.name = 'Regressive: Left-\lambda 60, Right-\lambda 30';
grouped_conditions{23}.tf = [.5 4 8];
grouped_conditions{23}.motion = 'regressive';
grouped_conditions{23}.speed = [.5 4 8]*4;
grouped_conditions{23}.list = {55,...
                              71,...
                              87};         
                          
grouped_conditions{24}.name = 'Regressive: Left-\lambda 90, Right-\lambda 30';
grouped_conditions{24}.tf = [.5 4 8];
grouped_conditions{24}.motion = 'regressive';
grouped_conditions{24}.speed = [.5 4 8]*4;
grouped_conditions{24}.list = {56,...
                              72,...
                              88};         
                          
grouped_conditions{25}.name = 'Regressive: Left-\lambda 15, Right-\lambda 60';
grouped_conditions{25}.tf = [.5 4 8];
grouped_conditions{25}.motion = 'regressive';
grouped_conditions{25}.speed = [.5 4 8]*4;
grouped_conditions{25}.list = {57,...
                              73,...
                              89};         
                          
grouped_conditions{26}.name = 'Regressive: Left-\lambda 30, Right-\lambda 60';
grouped_conditions{26}.tf = [.5 4 8];
grouped_conditions{26}.motion = 'regressive';
grouped_conditions{26}.speed = [.5 4 8]*4;
grouped_conditions{26}.list = {58,...
                              74,...
                              90};         
                          
grouped_conditions{27}.name = 'Regressive: Left-\lambda 60, Right-\lambda 60';
grouped_conditions{27}.tf = [.5 4 8];
grouped_conditions{27}.motion = 'regressive';
grouped_conditions{27}.speed = [.5 4 8]*4;
grouped_conditions{27}.list = {59,...
                              75,...
                              91};         
                          
grouped_conditions{28}.name = 'Regressive: Left-\lambda 90, Right-\lambda 60';
grouped_conditions{28}.tf = [.5 4 8];
grouped_conditions{28}.motion = 'regressive';
grouped_conditions{28}.speed = [.5 4 8]*4;
grouped_conditions{28}.list = {60,...
                              76,...
                              92};
                          
grouped_conditions{29}.name = 'Regressive: Left-\lambda 15, Right-\lambda 90';
grouped_conditions{29}.tf = [.5 4 8];
grouped_conditions{29}.motion = 'regressive';
grouped_conditions{29}.speed = [.5 4 8]*4;
grouped_conditions{29}.list = {61,...
                              77,...
                              93};         
                          
grouped_conditions{30}.name = 'Regressive: Left-\lambda 30, Right-\lambda 90';
grouped_conditions{30}.tf = [.5 4 8];
grouped_conditions{30}.motion = 'regressive';
grouped_conditions{30}.speed = [.5 4 8]*4;
grouped_conditions{30}.list = {62,...
                              78,...
                              94};
                          
grouped_conditions{31}.name = 'Regressive: Left-\lambda 60, Right-\lambda 90';
grouped_conditions{31}.tf = [.5 4 8];
grouped_conditions{31}.motion = 'regressive';
grouped_conditions{31}.speed = [.5 4 8]*4;
grouped_conditions{31}.list = {63,...
                              79,...
                              95};
                          
grouped_conditions{32}.name = 'Regressive: Left-\lambda 90, Right-\lambda 90';
grouped_conditions{32}.tf = [.5 4 8];
grouped_conditions{32}.motion = 'regressive';
grouped_conditions{32}.speed = [.5 4 8]*4;
grouped_conditions{32}.list = {64,...
                              80,...
                              96};