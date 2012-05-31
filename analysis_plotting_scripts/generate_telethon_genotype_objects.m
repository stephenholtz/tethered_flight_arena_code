try

%% Make set of genotype objects for the telethon - pack prior
clear variables;
datestr(now,31)
%% 55d05 **
loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '55d05-55d05_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_55d05_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)
time = '2';

for g = 1:numel(geno_55d05_kir21.experiment)
    if strcmpi(geno_55d05_kir21.experiment{g}.temp_shift(1),time);
        geno_55d05_kir21.experiment{g}.selected = 1;
    else
        geno_55d05_kir21.experiment{g}.selected = 0;
    end    
end
shifted_geno_55d05_kir21 = tfAnalysis.Genotype(geno_55d05_kir21.experiment)
save('shifted_geno_55d05_kir21','shifted_geno_55d05_kir21')
datestr(now,31)

time = '0';

for g = 1:numel(geno_55d05_kir21.experiment)
    if strcmpi(geno_55d05_kir21.experiment{g}.temp_shift(1),time);
        geno_55d05_kir21.experiment{g}.selected = 1;
    else
        geno_55d05_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_55d05_kir21 = tfAnalysis.Genotype(geno_55d05_kir21.experiment)
save('unshifted_geno_55d05_kir21','unshifted_geno_55d05_kir21')
datestr(now,31)

clear variables

%% 22b02 
loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '22b02-22b02_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_22b02_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_22b02_kir21.experiment)
    if strcmpi(geno_22b02_kir21.experiment{g}.temp_shift(1),time);
        geno_22b02_kir21.experiment{g}.selected = 1;
    else
        geno_22b02_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_22b02_kir21 = tfAnalysis.Genotype(geno_22b02_kir21.experiment)
save('shifted_geno_22b02_kir21','shifted_geno_22b02_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_22b02_kir21.experiment)
    if strcmpi(geno_22b02_kir21.experiment{g}.temp_shift(1),time);
        geno_22b02_kir21.experiment{g}.selected = 1;
    else
        geno_22b02_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_22b02_kir21 = tfAnalysis.Genotype(geno_22b02_kir21.experiment)
save('unshifted_geno_22b02_kir21','unshifted_geno_22b02_kir21')
datestr(now,31)

clear variables

%% 76e09 

loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '76e09-76e09_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_76e09_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_76e09_kir21.experiment)
    if strcmpi(geno_76e09_kir21.experiment{g}.temp_shift(1),time);
        geno_76e09_kir21.experiment{g}.selected = 1;
    else
        geno_76e09_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_76e09_kir21 = tfAnalysis.Genotype(geno_76e09_kir21.experiment)
save('shifted_geno_76e09_kir21','shifted_geno_76e09_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_76e09_kir21.experiment)
    if strcmpi(geno_76e09_kir21.experiment{g}.temp_shift(1),time);
        geno_76e09_kir21.experiment{g}.selected = 1;
    else
        geno_76e09_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_76e09_kir21 = tfAnalysis.Genotype(geno_76e09_kir21.experiment)
save('unshifted_geno_76e09_kir21','unshifted_geno_76e09_kir21')
datestr(now,31)

clear variables

%% 24g09 

loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '24g09-24g09_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_24g09_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_24g09_kir21.experiment)
    if strcmpi(geno_24g09_kir21.experiment{g}.temp_shift(1),time);
        geno_24g09_kir21.experiment{g}.selected = 1;
    else
        geno_24g09_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_24g09_kir21 = tfAnalysis.Genotype(geno_24g09_kir21.experiment)
save('shifted_geno_24g09_kir21','shifted_geno_24g09_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_24g09_kir21.experiment)
    if strcmpi(geno_24g09_kir21.experiment{g}.temp_shift(1),time);
        geno_24g09_kir21.experiment{g}.selected = 1;
    else
        geno_24g09_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_24g09_kir21 = tfAnalysis.Genotype(geno_24g09_kir21.experiment)
save('unshifted_geno_24g09_kir21','unshifted_geno_24g09_kir21')
datestr(now,31)

clear variables

%% 67a04
 
loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '67a04-67a04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_67a04_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_67a04_kir21.experiment)
    if strcmpi(geno_67a04_kir21.experiment{g}.temp_shift(1),time);
        geno_67a04_kir21.experiment{g}.selected = 1;
    else
        geno_67a04_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_67a04_kir21 = tfAnalysis.Genotype(geno_67a04_kir21.experiment)
save('shifted_geno_67a04_kir21','shifted_geno_67a04_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_67a04_kir21.experiment)
    if strcmpi(geno_67a04_kir21.experiment{g}.temp_shift(1),time);
        geno_67a04_kir21.experiment{g}.selected = 1;
    else
        geno_67a04_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_67a04_kir21 = tfAnalysis.Genotype(geno_67a04_kir21.experiment)
save('unshifted_geno_67a04_kir21','unshifted_geno_67a04_kir21')
datestr(now,31)

clear variables
 

%% 19c07

loc =  '/Users/holtzs/Desktop/telethon_experiment_2011';
genotype = '19c07-19c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_19c07_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_19c07_kir21.experiment)
    if strcmpi(geno_19c07_kir21.experiment{g}.temp_shift(1),time);
        geno_19c07_kir21.experiment{g}.selected = 1;
    else
        geno_19c07_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_19c07_kir21 = tfAnalysis.Genotype(geno_19c07_kir21.experiment)
save('shifted_geno_19c07_kir21','shifted_geno_19c07_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_19c07_kir21.experiment)
    if strcmpi(geno_19c07_kir21.experiment{g}.temp_shift(1),time);
        geno_19c07_kir21.experiment{g}.selected = 1;
    else
        geno_19c07_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_19c07_kir21 = tfAnalysis.Genotype(geno_19c07_kir21.experiment)
save('unshifted_geno_19c07_kir21','unshifted_geno_19c07_kir21')
datestr(now,31)

clear variables
 

%% 89c04

loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '89c04-89c04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_89c04_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_89c04_kir21.experiment)
    if strcmpi(geno_89c04_kir21.experiment{g}.temp_shift(1),time);
        geno_89c04_kir21.experiment{g}.selected = 1;
    else
        geno_89c04_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_89c04_kir21 = tfAnalysis.Genotype(geno_89c04_kir21.experiment)
save('shifted_geno_89c04_kir21','shifted_geno_89c04_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_89c04_kir21.experiment)
    if strcmpi(geno_89c04_kir21.experiment{g}.temp_shift(1),time);
        geno_89c04_kir21.experiment{g}.selected = 1;
    else
        geno_89c04_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_89c04_kir21 = tfAnalysis.Genotype(geno_89c04_kir21.experiment)
save('unshifted_geno_89c04_kir21','unshifted_geno_89c04_kir21')
datestr(now,31)

clear variables

%% 11c07

loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '11c07-11c07_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_11c07_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_11c07_kir21.experiment)
    if strcmpi(geno_11c07_kir21.experiment{g}.temp_shift(1),time);
        geno_11c07_kir21.experiment{g}.selected = 1;
    else
        geno_11c07_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_11c07_kir21 = tfAnalysis.Genotype(geno_11c07_kir21.experiment)
save('shifted_geno_11c07_kir21','shifted_geno_11c07_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_11c07_kir21.experiment)
    if strcmpi(geno_11c07_kir21.experiment{g}.temp_shift(1),time);
        geno_11c07_kir21.experiment{g}.selected = 1;
    else
        geno_11c07_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_11c07_kir21 = tfAnalysis.Genotype(geno_11c07_kir21.experiment)
save('unshifted_geno_11c07_kir21','unshifted_geno_11c07_kir21')
datestr(now,31)

clear variables
 

%% 13g04

loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '13g04-13g04_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_13g04_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_13g04_kir21.experiment)
    if strcmpi(geno_13g04_kir21.experiment{g}.temp_shift(1),time);
        geno_13g04_kir21.experiment{g}.selected = 1;
    else
        geno_13g04_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_13g04_kir21 = tfAnalysis.Genotype(geno_13g04_kir21.experiment)
save('shifted_geno_13g04_kir21','shifted_geno_13g04_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_13g04_kir21.experiment)
    if strcmpi(geno_13g04_kir21.experiment{g}.temp_shift(1),time);
        geno_13g04_kir21.experiment{g}.selected = 1;
    else
        geno_13g04_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_13g04_kir21 = tfAnalysis.Genotype(geno_13g04_kir21.experiment)
save('unshifted_geno_13g04_kir21','unshifted_geno_13g04_kir21')
datestr(now,31)

clear variables

%% 42f06

loc =  'C:\Users\labadmin\Desktop\telethon_experiment_2011';
genotype = '42f06-42f06_tubp_gal80ts-uas_kir_2.1__gal80ts_kir21';
geno_42f06_kir21 = tfAnalysis.import(fullfile(loc,genotype),'all')
datestr(now,31)

time = '2';
for g = 1:numel(geno_42f06_kir21.experiment)
    if strcmpi(geno_42f06_kir21.experiment{g}.temp_shift(1),time);
        geno_42f06_kir21.experiment{g}.selected = 1;
    else
        geno_42f06_kir21.experiment{g}.selected = 0;
    end    
end

shifted_geno_42f06_kir21 = tfAnalysis.Genotype(geno_42f06_kir21.experiment)
save('shifted_geno_42f06_kir21','shifted_geno_42f06_kir21')
datestr(now,31)

time = '0';
for g = 1:numel(geno_42f06_kir21.experiment)
    if strcmpi(geno_42f06_kir21.experiment{g}.temp_shift(1),time);
        geno_42f06_kir21.experiment{g}.selected = 1;
    else
        geno_42f06_kir21.experiment{g}.selected = 0;
    end    
end

unshifted_geno_42f06_kir21 = tfAnalysis.Genotype(geno_42f06_kir21.experiment)
save('unshifted_geno_42f06_kir21','unshifted_geno_42f06_kir21')
datestr(now,31)

clear variables

catch err
    Exp.Utilities.send_email('messed up during genotype objects','')
    error('failed')
end

    Exp.Utilities.send_email('finished up genotype objects','')
