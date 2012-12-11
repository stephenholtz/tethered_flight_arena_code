function hg_update_pull(verbose_flag)

if nargin == 0
    verbose_flag = 0;
elseif nargin == 1;
elseif nargin > 1;
    error('See function guts')
end
currDir = cd;
cd('C:\tethered_flight_arena_code\')

pullString = ['hg pull https://sholtz:cvtiC3Bb@bitbucket.org/sholtz/tethered_flight_arena_code'];
[PullStatus, PullResult] = dos(pullString);
if verbose_flag == 1;
fprintf('%s >>> %s status = %d \n',pullString,PullResult,PullStatus);
end

updateString = ['hg update'];
[UpdateStatus, UpdateResult] = dos(updateString);
if verbose_flag == 1;
fprintf('%s >>> %s status = %d \n',updateString,UpdateResult,UpdateStatus);
end

% show how it worked out
disp(PullResult)
disp(UpdateResult)

cd(currDir);

% working?