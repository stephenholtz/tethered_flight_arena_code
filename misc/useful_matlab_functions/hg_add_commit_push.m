function hg_add_commit_push(verbose_flag)
% commit and push to the bitbucket site, prolly shouldn't have the password
% as plaintext... oh well

if nargin == 0
    verbose_flag = 0;
elseif nargin == 1;
elseif nargin > 1;
    error('See function guts')
end

currDir = cd;

% Default location for the code.
cd('C:\tethered_flight_arena_code\')

% Remove files deleted in the explorer (vs with hg remove)
deletedString = 'hg status -d';
[DeletedStatus, DeletedResult] =  dos(deletedString);
delFiles = regexp(DeletedResult,'!\s\S*','match');
for f = 1:numel(delFiles)
removeString = ['hg remove ' delFiles{f}(3:end)];
[RemovedStatus, RemovedResult] = dos(removeString);
end

if numel(delFiles) > 0
    RemovedResult = [num2str(numel(delFiles)) ' removals'];
else
    RemovedResult = 'no removals';
end

% add the new files
updateString = 'hg add *';
[AddStatus, AddResult] =  dos(updateString);
if verbose_flag == 1;
fprintf('%s >>> %s status = %d \n',updateString,AddResult,AddStatus);
end

% commit
commitString = ['hg commit -m ''' datestr(now,30) '-matlab-commit'' -u sholtz'];
[CommitStatus, CommitResult] =  dos(commitString);
if verbose_flag == 1;
fprintf('%s >>> %s status = %d \n',commitString,CommitResult,CommitStatus);
end

% push
pushString = ['hg push https://sholtz:cvtiC3Bb@bitbucket.org/sholtz/tethered_flight_arena_code'];
[PushStatus, PushResult] = dos(pushString);
if verbose_flag == 1;
fprintf('%s >>> %s status = %d \n',PushResult,result4,PushStatus);
end

% show how it worked out
disp(DeletedResult)
disp(RemovedResult)
disp(AddResult)
disp(CommitResult)
disp(PushResult)

cd(currDir)