% Example of class structure with file system use for data analysis 
% Using mushroom body lines in the short telethon conditions.

cpt_exp =0; cpt_geno = 0; db_do = 0; do_plots = 1;

addpath(genpath('C:\tethered_flight_arena_code'));

%% Make a few objects using the import function 

% This is not practical, all of the data generated per 15 flies is quite
% large. Smaller than the sum of the raw data files, but only by about a
% factor of 2.

if  cpt_exp == 1;

disp('MB004B')
    MB004B = tfAnalysis.import('C:\tf_tmpfs\short_telethon_experiment_20120111\13f02-13f02_26e07-26e07','all');
    save('MB004B','MB004B')
    clear all; pause(.01)
disp('MB005B')
    MB005B = tfAnalysis.import('C:\tf_tmpfs\short_telethon_experiment_20120111\13f02-13f02_34a03-34a03','all');
    save('MB005B','MB005B')
    clear all; pause(.01)
disp('MB008B')
    MB008B = tfAnalysis.import('C:\tf_tmpfs\short_telethon_experiment_20120111\13f02-13f02_44e04-44e04','all');
    save('MB008B','MB008B')
    clear all; pause(.01)
disp('MB009B')
    MB009B = tfAnalysis.import('C:\tf_tmpfs\short_telethon_experiment_20120111\13f02-13f02_45h04-45h04','all');
    save('MB009B','MB009B')
    clear all; pause(.01)
disp('MB107B')
    MB107B = tfAnalysis.import('C:\tf_tmpfs\short_telethon_experiment_20120111\19b03-19b03_52h09-52h09','all');
    save('MB107B','MB107B')
    clear all; pause(.01)
end

%% Each object can be analyzed with the genotype class also to compare conditions across experiments
% Right now the Genotype class calls methods of the Experiment class that
% compute across trial averages and uses those averages to find means of
% means for each condition in a given genotype (/given protocol).

% The genotypes are kept small here by not including all of the raw lower
% levels, but this can be added back in by a call to the database or using
% the import function again and pointing it at the experiment property
% within the Genotype class.

if cpt_geno == 1;
    
load('MB004B');
    gMB004B = tfAnalysis.Genotype(MB004B);
    save('gMB004B','gMB004B')
    clear all; pause(.01)
    
load('MB005B');
    eMB005B = MB005B.experiment;
    gMB005B = tfAnalysis.Genotype(eMB005B);
    save('gMB005B','gMB005B')
    clear all; pause(.01)
    
load('MB008B');
    eMB008B = MB008B.experiment;
    gMB008B = tfAnalysis.Genotype(eMB008B);
    save('gMB008B','gMB008B')
    clear all; pause(.01)
    
load('MB009B');
    eMB009B = MB009B.experiment;
    gMB009B = tfAnalysis.Genotype(eMB009B);
    save('gMB009B','gMB009B')
    clear all; pause(.01)
    
load('MB107B');
    eMB107B = MB107B.experiment;
	gMB107B = tfAnalysis.Genotype(eMB107B);
    save('gMB107B','gMB107B')
    clear all; pause(.01)
    
end

%% Example of using the database to upload the data in the file paths above
% NOTE: the uploader will throw an error if an identical experiment exists.
% To clear all the database use these sql commands:
% DELETE FROM `flynet`.`data`;
% DELETE FROM `flynet`.`trial_property`;
% DELETE FROM `flynet`.`trial`;
% DELETE FROM `flynet`.`experiment_property`;
% DELETE FROM `flynet`.`experiment`;
%
if db_do == 1;
% Directory with all of the genotypes. Is iterated over, display updates
% with progress.
FlyNet.Push('C:\tf_tmpfs\short_telethon_experiment_20120111','tf')

% To retreive it from the database there is a pull function as well
experiments = FlyNet.Pull('short_telethon_experiment_20120111','protocol');

% This is equivalent to:
experiments = FlyNet.Pull('SELECT id FROM experiment WHERE protocol = "short_telethon_experiment_20120111"','literal');

% Getting one genotype is not yet automated, but could be easily...
MB004B = FlyNet.Pull(['SELECT id FROM experiment WHERE ',...
                                    'chr2 = "13f02-13f02" AND '...
                                    'chr3 = "26e07-26e07" AND ',... 
                                    'effector = "kir21" AND ',...
                                    'protocol = "short_telethon_experiment_20120111"'],'literal');
% Just pull one for testing purposes                                
MB004B = FlyNet.Pull(['SELECT id FROM experiment WHERE ',...
                                    'id = "2" AND ',...
                                    'protocol = "short_telethon_experiment_20120111"'],'literal');
                                
save('MB004B','MB004B')

% Offline analysis of genotypes for now is the same as with filesystems
gMB004B = tfAnalysis.Genotype(MB004B);
save('gMB004B','gMB004B')

end

%% Data Access (/Plotting)
% This should be the easiest part, aside from making things pretty.
if do_plots == 1;
% For example in these mushroom body lines, I cannabilized some of John's
% figure making code to make the following comparisons across all
% genotypes... I need controls now... Getting data from Johns files was
% harder than I thought.

load('gMB004B');
load('gMB005B');
load('gMB008B');
load('gMB009B');
load('gMB107B');

data_objs = {'gMB004B','gMB005B','gMB008B','gMB009B','gMB107B' };
data_color ={[0 1 0];  [1 0 0] ; [0 0 1];  [1 0 1];  [1 1 0]};
color_names= {'green','red', 'blue', 'magenta','yellow'};
expr_pat= {'KC all','KC alpha'' beta''', 'KC alpha beta', 'KC gamma','KC all'};
n_flies = {'11','15','15','15','14'}; % Written when db was down..
% Make the figure:
main_fh = figure;
figName = 'Mushroom Body Lines in Short Telethon: Summary';
set(main_fh,'NumberTitle','off','Name',figName,'Position',[50,50,755,1025],'PaperOrientation','portrait','Color','w');
annotation(main_fh, 'textbox',[.035 .885 .1 .1],'String',figName,'FontSize',12, 'FontWeight','demi', 'EdgeColor', 'white')

%% FIGURE p1 - Summary Metadata + Stripe Fixation                     {1 cond}
    % make metadata uitable with all our properties
    values = [];
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        meta_fields = {'chr2', 'chr3', 'effector','protocol'};
        for m = 1:numel(meta_fields)
            value{m} = getfield(curr_obj, meta_fields{m});
        end
        values = [values; value];
    end
    uitable('Parent',main_fh, 'Units','normalized','Position',[.015 .80 .72 .15],'ColumnWidth',{88},...
            'RowName',[(meta_fields),  'expression' ,'N','color'],'ColumnName',[data_objs],...
            'Data', [values';expr_pat; n_flies; color_names]);
    
    % add the stripe fixation data (condition 17)
    stripe_fix_h = axes;
    set(stripe_fix_h,'OuterPosition',[.7325 .77 .27 .21],'Box','on');
    stripe_fix_th = title({'Stripe Fixation'; '[10 sec bouts]'});
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
%         plot(stripe_fix_h, curr_obj.hist_96_x_pos{17}, 'Color',data_color{i});
%         [n, xout]= hist(curr_obj.mean_x_pos{17},96);
%         h = n./numel(curr_obj.mean_x_pos{17});
%         plot(stripe_fix_h,xout, h, 'Color',data_color{i});
        plot(stripe_fix_h,(curr_obj.hist_96_x_pos{17}(1:2:end))+(curr_obj.hist_96_x_pos{17}(2:2:end))/2,'Color',data_color{i})
    end
    
%% FIGURE p2 - Unilateral Motion + Reverse Phi [= Velocity Nulling]    {6 conds}
    annotation(main_fh, 'textbox',[.05 .685 .1 .1],'String',['Unilateral Motion'], 'EdgeColor', 'white','FontWeight','demi')
    
    % clockwise b2f = 1 ccw b2f = 2
    
    b2f_h = axes; 
    set(b2f_h,'OuterPosition',[.025 .55 .25 .20],'Box','on')
    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{1});
        data{2} = -double(curr_obj.mean_lmr{2});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{1});
        sem{2} = -double(curr_obj.sem_lmr{2});
        sem = mean(cell2mat(sem),2);
        plot(b2f_h, data, 'Color',data_color{i},'LineWidth',1);
%         plot(b2f_h, sem + data,'k');
%         plot(b2f_h, -sem + data,'k');
        title({'Back to Front CW Motion'});        
        clear data sem
    end
    
    % more information on the above response, time to half max and
    % integrated response
    
    b2f_t_half_h = axes; 
    
        for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        set(b2f_t_half_h,'OuterPosition',[.035 .385 .11 .16],'Box','off')
        time2half = [double(curr_obj.time_to_half_max_lmr{1}) + double(curr_obj.time_to_half_max_lmr{2})]/2;
        time2halfsem = [double(curr_obj.time_to_half_max_lmr_sem{1}) + double(curr_obj.time_to_half_max_lmr_sem{2})]/2;
        errorbar(b2f_t_half_h,i*.05,time2half,time2halfsem,'o', 'Color',data_color{i}); 
        set(gca,'XTick',[])
        hold on;
        title('t_h_a_l_f_ _m_a_x')
        end
    
    b2f_int_resp_h = axes; 
    
        for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});            
        set(b2f_int_resp_h,'OuterPosition',[.14 .385 .11 .16],'Box','off')
        int_resp = [double(curr_obj.integrated_lmr_response{1}) + double(curr_obj.integrated_lmr_response{2})]/2;
        int_resp_sem = [double(curr_obj.integrated_lmr_response_sem{1}) + double(curr_obj.integrated_lmr_response_sem{2})]/2;
        errorbar(b2f_int_resp_h,i*.05,int_resp,int_resp_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('\Sigma_l_m_r')
        end
        
    % clockwise f2b = 3 ccw f2b = 4
    f2b_h = axes;
    set(f2b_h,'OuterPosition',[.255 .55 .25 .20],'Box','on')    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{3});
        data{2} = -double(curr_obj.mean_lmr{4});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{3});
        sem{2} = -double(curr_obj.sem_lmr{4});
        sem = mean(cell2mat(sem),2);
        plot(f2b_h, data, 'Color',data_color{i});
%         plot(f2b_h, sem + data,'k');
%         plot(f2b_h, -sem + data,'k');
        title({'Front to Back CW Motion'});                
        clear data sem
    end
    
    % more information on the above response, time to half max and
    % integrated response
    b2f_t_half_h = axes; 
        for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        set(b2f_t_half_h,'OuterPosition',[.265 .385 .11 .16],'Box','off')
        time2half = [double(curr_obj.time_to_half_max_lmr{3}) + double(curr_obj.time_to_half_max_lmr{4})]/2;
        time2halfsem = [double(curr_obj.time_to_half_max_lmr_sem{3}) + double(curr_obj.time_to_half_max_lmr_sem{4})]/2;
        errorbar(b2f_t_half_h,i*.05,time2half,time2halfsem,'o', 'Color',data_color{i}); 
        set(gca,'XTick',[])
        hold on;
        title('t_h_a_l_f_ _m_a_x')
        end
    b2f_int_resp_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});
        set(b2f_int_resp_h,'OuterPosition',[.37 .385 .11 .16],'Box','off')
        int_resp = [double(curr_obj.integrated_lmr_response{3}) + double(curr_obj.integrated_lmr_response{4})]/2;
        int_resp_sem = [double(curr_obj.integrated_lmr_response_sem{3}) + double(curr_obj.integrated_lmr_response_sem{4})]/2;
        errorbar(b2f_int_resp_h,i*.05,int_resp,int_resp_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('\Sigma_l_m_r')
        end
%% FIGURE p3 - Low Contrast Rotation                                  {4 conds}
    annotation(main_fh, 'textbox',[.50 .685 .1 .1],'String',['Low Conrast (Bilateral) Rotation'], 'EdgeColor', 'white', 'FontWeight','demi')
    
    % clockwise lower contrast (.06) - conds 5 , 6 

        lc_rot_h = axes; 
        set(lc_rot_h,'OuterPosition',[.485 .55 .25 .20],'Box','on')    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{5});
        data{2} = -double(curr_obj.mean_lmr{6});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{5});
        sem{2} = -double(curr_obj.sem_lmr{6});
        sem = mean(cell2mat(sem),2);
        plot(lc_rot_h, data, 'Color',data_color{i});
%         plot(lc_rot_h, sem + data,'k');
%         plot(lc_rot_h, -sem + data,'k');
        title({'Contrast = .06'});        
        clear data sem
    end
    
    b2f_t_half_h = axes; 
        for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});    
        set(b2f_t_half_h,'OuterPosition',[.495 .385 .11 .16],'Box','off')
        time2half = [double(curr_obj.time_to_half_max_lmr{5}) + double(curr_obj.time_to_half_max_lmr{4})]/2;
        time2halfsem = [double(curr_obj.time_to_half_max_lmr_sem{5}) + double(curr_obj.time_to_half_max_lmr_sem{4})]/2;
        errorbar(b2f_t_half_h,i*.05,time2half,time2halfsem,'o', 'Color',data_color{i}); 
        set(gca,'XTick',[])
        hold on;
        title('t_h_a_l_f_ _m_a_x')
        end
    b2f_int_resp_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(b2f_int_resp_h,'OuterPosition',[.60 .385 .11 .16],'Box','off')
        int_resp = [double(curr_obj.integrated_lmr_response{5}) + double(curr_obj.integrated_lmr_response{6})]/2;
        int_resp_sem = [double(curr_obj.integrated_lmr_response_sem{5}) + double(curr_obj.integrated_lmr_response_sem{6})]/2;
        errorbar(b2f_int_resp_h,i*.05,int_resp,int_resp_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('\Sigma_l_m_r')
        end
    % clockwise higher contrast (.24) - conds 7, 8 
    hc_rot_h = axes; 
    set(hc_rot_h,'OuterPosition',[.715 .55 .25 .20],'Box','on')    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{7});
        data{2} = -double(curr_obj.mean_lmr{8});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{7});
        sem{2} = -double(curr_obj.sem_lmr{8});
        sem = mean(cell2mat(sem),2);
        plot(hc_rot_h, data, 'Color',data_color{i});
%         plot(hc_rot_h, sem + data,'k');
%         plot(hc_rot_h, -sem + data,'k');
        title({'Contrast = .24'});                
        clear data sem
    end
    
    b2f_t_half_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(b2f_t_half_h,'OuterPosition',[.725 .385 .11 .16],'Box','off')
        time2half = [double(curr_obj.time_to_half_max_lmr{7}) + double(curr_obj.time_to_half_max_lmr{8})]/2;
        time2halfsem = [double(curr_obj.time_to_half_max_lmr_sem{7}) + double(curr_obj.time_to_half_max_lmr_sem{8})]/2;
        errorbar(b2f_t_half_h,i*.05,time2half,time2halfsem,'o', 'Color',data_color{i}); 
        set(gca,'XTick',[])
        hold on;
        title('t_h_a_l_f_ _m_a_x')
        end
    b2f_int_resp_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(b2f_int_resp_h,'OuterPosition',[.83 .385 .11 .16],'Box','off')
        int_resp = [double(curr_obj.integrated_lmr_response{7}) + double(curr_obj.integrated_lmr_response{8})]/2;
        int_resp_sem = [double(curr_obj.integrated_lmr_response_sem{7}) + double(curr_obj.integrated_lmr_response_sem{8})]/2;
        errorbar(b2f_int_resp_h,i*.05,int_resp,int_resp_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('\Sigma_l_m_r')
        end
%% FIGURE p4 - Stripe Tracking                                        {6 conds}
    annotation(main_fh, 'textbox',[.05 .28 .1 .1],'String',['Stripe Tracking (sine waves)'], 'EdgeColor', 'white','FontWeight','demi')
    
    % Bright background, negative contrast - 1 stripe ( 11,12 )
    nc_h = axes;
    set(nc_h,'OuterPosition',[.035 .16 .25 .20],'Box','on')    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{11});
        data{2} = -double(curr_obj.mean_lmr{12});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{11});
        sem{2} = -double(curr_obj.sem_lmr{12});
        sem = mean(cell2mat(sem),2);
        plot(nc_h, data, 'Color',data_color{i});
%         plot(nc_h, sem + data,'k');
%         plot(nc_h, -sem + data,'k');
        title({'Negative Contrast'; 'Single Stripe Sine Wave'});
        clear data sem
    end
    
    nc_corr_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(nc_corr_h,'OuterPosition',[.035 .005 .11 .16],'Box','off')
        corr_x_lmr = [double(curr_obj.corr_x_lmr{11}) + double(curr_obj.corr_x_lmr{12})]/2;
        corr_x_lmr_sem = [double(curr_obj.corr_x_lmr_sem{11}) + double(curr_obj.corr_x_lmr_sem{12})]/2;
        errorbar(nc_corr_h,i*.05,corr_x_lmr,corr_x_lmr_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('Correlation')
        end
    nc_peak_h = axes;
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(nc_peak_h,'OuterPosition',[.15 .005 .11 .16],'Box','off')
        lags_x_lmr = [double(curr_obj.lag_corr_x_lmr{11}) + double(curr_obj.lag_corr_x_lmr{12})]/2;
        lags_x_lmr_sem = [double(curr_obj.lag_corr_x_lmr_sem{11}) + double(curr_obj.lag_corr_x_lmr_sem{12})]/2;
        errorbar(nc_peak_h,i*.05,lags_x_lmr,lags_x_lmr_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('Peak Lag')
        end
    % Dark background, positive contrast - 1 stripe ( 13,14 )
    pc_h = axes;
    set(pc_h,'OuterPosition',[.255 .16 .25 .20],'Box','on')
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{13});
        data{2} = -double(curr_obj.mean_lmr{14});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{13});
        sem{2} = -double(curr_obj.sem_lmr{14});
        sem = mean(cell2mat(sem),2);
        plot(pc_h, data, 'Color',data_color{i});
%         plot(pc_h, sem + data,'k');
%         plot(pc_h, -sem + data,'k');
        title({'Positive Contrast'; 'Single Stripe Sine Wave'});
        clear data sem
    end
    
    nc_corr_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(nc_corr_h,'OuterPosition',[.255 .005 .11 .16],'Box','off')
        corr_x_lmr = [double(curr_obj.corr_x_lmr{13}) + double(curr_obj.corr_x_lmr{14})]/2;
        corr_x_lmr_sem = [double(curr_obj.corr_x_lmr_sem{13}) + double(curr_obj.corr_x_lmr_sem{14})]/2;
        errorbar(nc_corr_h,i*.05,corr_x_lmr,corr_x_lmr_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('Correlation')
        end
    nc_peak_h = axes;
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(nc_peak_h,'OuterPosition',[.38 .005 .11 .16],'Box','off')
        lags_x_lmr = [double(curr_obj.lag_corr_x_lmr{13}) + double(curr_obj.lag_corr_x_lmr{14})]/2;
        lags_x_lmr_sem = [double(curr_obj.lag_corr_x_lmr_sem{13}) + double(curr_obj.lag_corr_x_lmr_sem{14})]/2;
        errorbar(nc_peak_h,i*.05,lags_x_lmr,lags_x_lmr_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('Peak Lag')    
        end
    % Grated background ( 15, 16 )
    gb_h = axes;
    set(gb_h,'OuterPosition',[.475 .16 .25 .20],'Box','on')    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{15});
        data{2} = -double(curr_obj.mean_lmr{16});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{15});
        sem{2} = -double(curr_obj.sem_lmr{16});
        sem = mean(cell2mat(sem),2);
        plot(gb_h, data, 'Color',data_color{i});
%         plot(gb_h, sem + data,'k');
%         plot(gb_h, -sem + data,'k');
        title({'Grating Sine Wave'; ' '});
        clear data sem
    end
    
    nc_corr_h = axes; 
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(nc_corr_h,'OuterPosition',[.475 .005 .11 .16],'Box','off')
        corr_x_lmr = [double(curr_obj.corr_x_lmr{15}) + double(curr_obj.corr_x_lmr{16})]/2;
        corr_x_lmr_sem = [double(curr_obj.corr_x_lmr_sem{15}) + double(curr_obj.corr_x_lmr_sem{16})]/2;
        errorbar(nc_corr_h,i*.05,corr_x_lmr,corr_x_lmr_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])
        hold on;
        title('Correlation')
        end
    nc_peak_h = axes;
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(nc_peak_h,'OuterPosition',[.6 .005 .11 .16],'Box','off')
        lags_x_lmr = [double(curr_obj.lag_corr_x_lmr{15}) + double(curr_obj.lag_corr_x_lmr{16})]/2;
        lags_x_lmr_sem = [double(curr_obj.lag_corr_x_lmr_sem{15}) + double(curr_obj.lag_corr_x_lmr_sem{16})]/2;
        errorbar(nc_peak_h,i*.05,lags_x_lmr,lags_x_lmr_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])        
        hold on;
        title('Peak Lag')
        end
%% Figure p5 - reverse phi motion
    annotation(main_fh, 'textbox',[.752 .28 .1 .1],'String',['Reverse Phi Motion'], 'EdgeColor', 'white', 'FontWeight','demi')
    
    % Conditions 9 (clockwise apparent) and 10 (counterclockwise apparent)
    rp_h = axes; 
    set(rp_h,'OuterPosition',[.73 .16 .25 .20],'Box','on')    
    for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});
        hold on;
        data{1} = double(curr_obj.mean_lmr{9});
        data{2} = -double(curr_obj.mean_lmr{10});
        data= mean(cell2mat(data),2);
        sem{1} = double(curr_obj.sem_lmr{9});
        sem{2} = -double(curr_obj.sem_lmr{10});
        sem = mean(cell2mat(sem),2);
        plot(rp_h, data, 'Color',data_color{i});
%         plot(rp_h, sem + data,'k');
%         plot(rp_h, -sem + data,'k');
        title({'Reverse Phi'; 'Apparent CCW Motion'});                
        clear data sem
    end
    
    b2f_t_half_h = axes;
        for i = 1:numel(data_objs)
        curr_obj = eval(data_objs{i});    
        set(b2f_t_half_h,'OuterPosition',[.728 .008 .11 .16],'Box','off')
        time2half = [double(curr_obj.time_to_half_max_lmr{9}) + double(curr_obj.time_to_half_max_lmr{10})]/2;
        time2halfsem = [double(curr_obj.time_to_half_max_lmr_sem{9}) + double(curr_obj.time_to_half_max_lmr_sem{10})]/2;
        errorbar(b2f_t_half_h,i*.05,time2half,time2halfsem,'o', 'Color',data_color{i}); 
        set(gca,'XTick',[])
        hold on;
        title('t_h_a_l_f_ _m_a_x')
        end
    b2f_int_resp_h = axes;
        for i = 1:numel(data_objs)    
        curr_obj = eval(data_objs{i});    
        set(b2f_int_resp_h,'OuterPosition',[.86 .008 .11 .16],'Box','off')
        int_resp = [double(curr_obj.integrated_lmr_response{9}) + double(curr_obj.integrated_lmr_response{8})]/2;
        int_resp_sem = [double(curr_obj.integrated_lmr_response_sem{9}) + double(curr_obj.integrated_lmr_response_sem{10})]/2;
        errorbar(b2f_int_resp_h,i*.05,int_resp,int_resp_sem,'o', 'Color',data_color{i});
        set(gca,'XTick',[])        
        hold on;
        title('\Sigma_l_m_r')
        end
end