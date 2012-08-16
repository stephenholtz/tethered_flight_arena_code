function summ = generate_mat_file_for_telethon_genotype(genotype_object, varargin)
    % All of the conditions are going to be pulled out with descriptions
    % and condensed when needed into single vectors.
    
    % Each vector will be stored as part of a structure named by its
    % stimuli type i.e.:
    %       stripeFixData.closed_loop.ts_mean_sem = [mean_ts plus_sem_ts minus_sem_ts]
    %       stripeFixData.open_loop.thalf = [mean_thalf sem_thalf]
    %
    % MAKES: 
    % closedLoopData - 
    % stripeFixData -
    % unilateralData - 
    % onOffData - 
    % opticFlowData -
    % velNullData **
    % rotGratingData -
    % contrastData - 
    % revPhiData -
    % metadata
    
    % metadata (for N and genotype etc.,)
    
    summ.metadata.N = sum([genotype_object.selected{:}]);
    summ.metadata.effector = genotype_object.effector;
    summ.metadata.genotype = [genotype_object.chr2 ' | ' genotype_object.chr3];
    summ.metadata.line_name = genotype_object.line_name;
    
    % Pull out Stripe Fix Conditions
    % stripeFixData;
    % FREQ           -  1hz         3hz             5hz
    % dark on bright -  84/85       86/87           88/89
    % bright on dark -  90/91       92/93           94/95
    % square wave gra-  96/97       98/99           100/101
    
    % closed loop stripe fixation is trial 131
    
    summ.closedLoopData.lmr_ts_mean_sem{1} = genotype_object.get_timeseries([131],4); %#ok<*NBRAK,*STRNU>
    summ.closedLoopData.x_pos_ts_mean_sem{1} = genotype_object.get_timeseries([131],1,'x_pos');
    
    s_fix_mat ={[84, 85],...
                [86, 87],...
                [88, 89],...
                [90,91],...
                [92,93],...
                [94,95],...
                [96,97],...
                [98,99],...
                [100,101]};

    for g = 1:numel(s_fix_mat);

        summ.stripeFixData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(s_fix_mat{g},4);
        [summ.stripeFixData.corr_mean_sem{g},summ.stripeFixData.lag_mean_sem{g}] ...
            = genotype_object.cpt_corr_lag_vals(s_fix_mat{g},2);
        summ.stripeFixData.x_pos{g} = genotype_object.get_timeseries(s_fix_mat{g},3,'x_pos');
    end
    
    % Pull out Unilateral Conditions
    % unilateralData;
    % back to front clockwise motion @30,       @90,        @360 = 
    %                                120/121    124/125     128/129
    % front to back clockwise motion @30,       @90,        @360 =
    %                                122/123    126/127     130/(MISSING)
    
    u_mat  =   {[120, 121],...
                [124, 125],...
                [128, 129],...
                [122, 123],...
                [126,127],...
                [130]};
            
    for g = 1:numel(u_mat);
        
        summ.unilateralData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(u_mat{g},4);
        
        [summ.unilateralData.int_mean_sem{g}, summ.unilateralData.t75mean_mean_sem{g}]...
            = genotype_object.get_int_t75mean_mean_sem(u_mat{g},2);
        
    end
    
    % Pull out ON OFF Conditions
    % onOffData;
    % ON-L-Expansion    OFF-L-Expansion     SAW-ON-L    SAW-OFF-L
    % 113/114           115/116             117/118     119/(MISSING)
    
    oo_mat  =   {[113, 114],...
                [115, 116],...
                [117, 118],...
                [119]};

    for g = 1:numel(oo_mat);
        
        summ.onOffData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(oo_mat{g},4);
        
        [summ.onOffData.int_mean_sem{g}, summ.onOffData.t75mean_mean_sem{g},]...
            = genotype_object.get_int_t75mean_mean_sem(oo_mat{g},2);
        
    end
    
    % Pull out Optic Flow Conditions
    % opticFlowData;
    %   Lift      Pitch       Roll        SideSlip        Thrust      Yaw
    %   102/103   104/105     106/107     108/109         110/111     112/(MISSING)
    %   c1        c2          c3          c1              c2          c3
    
    flow_mat  ={[102, 103],...
                [104, 105],...
                [106, 107],...
                [108, 109],...
                [110, 111],...
                [112]};
    
    for g = 1:numel(flow_mat);
        
        summ.opticFlowData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(flow_mat{g},4);
        
        [summ.opticFlowData.corr_mean_sem{g}, summ.opticFlowData.lag_mean_sem{g}]...
            = genotype_object.cpt_corr_lag_vals(flow_mat{g},2);
        
        [summ.opticFlowData.int_mean_sem{g},summ.opticFlowData.t75mean_mean_sem{g}]...
            = genotype_object.get_int_t75mean_mean_sem(flow_mat{g},2);
        
        summ.opticFlowData.x_pos{g} = genotype_object.get_timeseries(flow_mat{g},3,'x_pos');
    end
    
    % Pull out Velocity Nulling Conditions
    % velNullData;
    % Ref Contrast => tf = 4, mc = 0.27
    %       tf  .3      1.3     5.3    10.6    16
    % mc .09    1/2     7/8     13/14  19/20   25/26
    % mc .27    3/4     9/10    15/16  21/22   27/28
    % mc .45    5/6     11/12   17/18  23/24   29/MISSING
    vn_mat  =  {[1,  2],...
                [7,  8],...
                [13,14],...
                [19,20],...
                [25,26],...
                [3,  4],...
                [9, 10],...
                [15,16],...
                [21,22],...
                [27,28],...
                [5,  6],...
                [11,12],...
                [17,18],...
                [23,24],...
                [29]};

    for g = 1:numel(vn_mat);

        summ.velNullData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(vn_mat{g},4);

        [summ.velNullData.int_mean_sem{g},summ.velNullData.t75mean_mean_sem{g}]...
            = genotype_object.get_int_t75mean_mean_sem(vn_mat{g},2);

    end
    
    % Pull out all of grating data
    % rotGratingData;
    % ROTATION
    %            tf-#(#d/s)
    % lambda 30: tf-.5(15) tf-3*(90)  tf-9(270)   tf-18(540)
    %            45/46     47/48      49/50       51/52
    % lambda 60: tf.25(15) tf1.5(90)  tf4.5(270)  tf-9(540)
    %            30/31     32/33      34/35       36/37
    % lambda 90: tf.17(15) tf-1(90)   tf-3(270)   tf-6(540)
    %            53/54     55/56      57/58       59/60
    % EXPANSION
    % lambda 30: tf-1(15)  tf-9(270)
    %            61/62     63/64
    %
    rg_mat  =  {[45,46],...
                [47,48],...
                [49,50],...
                [51,52],...
                [30,31],...
                [32,33],...
                [34,35],...
                [36,37],...
                [53,54],...
                [55,56],...
                [57,58],...
                [59,60],...
                [61,62],...
                [63,64]};

    for g = 1:numel(rg_mat);

        summ.rotGratingData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(rg_mat{g},4);
        
        [summ.rotGratingData.int_mean_sem{g},summ.rotGratingData.t75mean_mean_sem{g}]...
            = genotype_object.get_int_t75mean_mean_sem(rg_mat{g},2);

    end
    
    % CONTRASTS  (tf-8(180), all)
    % lambda 22.5: mc: .23  mc: .07 mc: .06 mc: .24
    %            65/66     67/68      69/70       71/72
    % contrastData;
    
    c_mat  =   {[65,66],...
                [67,68],...
                [69,70],...
                [71,72]};

    for g = 1:numel(c_mat);

        summ.contrastData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(c_mat{g},4);
        
        [summ.contrastData.int_mean_sem{g},summ.contrastData.t75mean_mean_sem{g}]...
             = genotype_object.get_int_t75mean_mean_sem(c_mat{g},2);

    end
    
    % Pull out Reverse Phi Conditions
    % revPhiData;
    % REV PHI
    % lambda 30: tf-1(30)  tf-3(90)   tf-9(270)
    %            73/74     75/76      77/78
    % lambda 90: tf.33*(30)tf-3(90)   tf-3(270)
    %            79/80     81/82      83/MISSING
    % 40 HZ FLICKER IS MISSING?!
    
    
    rp_mat  =  {[73,74],...
                [75,76],...
                [77,78],...
                [79,80],...
                [81,82],...
                [83]};

    for g = 1:numel(rp_mat);
    
        summ.revPhiData.lmr_ts_mean_sem{g} = genotype_object.get_timeseries(rp_mat{g},4);
        
        [summ.revPhiData.int_mean_sem{g},summ.revPhiData.t75mean_mean_sem{g}]...
            = genotype_object.get_int_t75mean_mean_sem(rp_mat{g},2);
    
    end    
    
% save it if anything else was passed
if numel(varargin) == 1
    save('summ','summ')
end

end