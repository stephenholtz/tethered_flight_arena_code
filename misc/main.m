classdef main < handle
% Main trial class
properties
% General variables
% -------------------------------------------------------------------------
    fly             % fly class objects

    fliesN          % number of flies in trial

    selectedFliesN  % number of selected flies

    selectedFlies   % index to selected flies  
    
    

    metaData

end

methods

   

function self = main(varargin)

    switch nargin

        case 0 % - no argument passed, initialize empty

            self.fliesN = 0;

        case 5 % - an experiment and trial ID were passed together with database credentials and arena, stimulus parameters and tracking params

            self.load(varargin{1},varargin{2},varargin{3},varargin{4},varargin{5});

            self.select('All');

        otherwise

            disp('Parameter set not defined for trial');

    end       

end

      

 

% Data loading functions

% -------------------------------------------------------------------------

function load(self,dbCredentials,trID,arenaParams,stimulusParams,trackingParams)

% load the data for a given trial from the database

    self.fliesN = 0;

    db = database_janelia(dbCredentials);

    % load fly IDs

    flyIDs = db.query(['SELECT id FROM tracking_data WHERE trial_id = "' num2str(trID) '"']);

    % load trial metaData

    self.metaData.trial_number = db.query(['SELECT trial_number FROM trials WHERE id = "' num2str(trID) '"']);

    self.metaData.duration = db.query(['SELECT duration FROM trials WHERE id = "' num2str(trID) '"']);

    self.metaData.interval = db.query(['SELECT `interval` FROM trials WHERE id = "' num2str(trID) '"']);

    self.metaData.arena_angle = db.query(['SELECT arena_angle FROM trials WHERE id = "' num2str(trID) '"']);

    self.metaData.lighting_protocol = db.query(['SELECT lighting_protocol FROM trials WHERE id = "' num2str(trID) '"']);

   

 

    if ~isempty(flyIDs) && ~strcmp(flyIDs,'No Data')

        self.add_trajectories(db,flyIDs,arenaParams,stimulusParams,trackingParams);

    else

        self.fly = [];

    end

   

    if trackingParams.stitching

        self.stitch_trajectories(arenaParams,stimulusParams,trackingParams);

    end

end

function add_trajectories(self,db,flyIDs,arenaParams,stimulusParams,trackingParams)

    for i=1:length(flyIDs)

        self.add_trajectory(db,flyIDs(i),arenaParams,stimulusParams,trackingParams);

    end

end

function add_trajectory(self,db,flyID,arenaParams,stimulusParams,trackingParams)

          

    % retrieve the encoded tracking data from the database for the given fly

    encoded = db.query(['SELECT data FROM tracking_data WHERE id="' num2str(flyID) '"']);

    % decode the encoded data

    decoded = db.decode_matrix(encoded, 'single');

   

    self.fliesN = self.fliesN+1;

    self.fly{self.fliesN} = trajectory.main(arenaParams,stimulusParams);

    self.fly{self.fliesN}.T = decoded(:,1);

    self.fly{self.fliesN}.X = decoded(:,2);

    self.fly{self.fliesN}.Y = decoded(:,3);

    self.fly{self.fliesN}.Theta = decoded(:,4);

   

%     if trackingParams.smoothing

%         self.fly{self.fliesN}.smooth_position_data(trackingParams.smoothSpan,trackingParams.smoothMethod);

%     end

    self.fly{self.fliesN}.smooth_position_data(3,'moving');

end

function stitch_trajectories(self,arenaParams,stimulusParams,trackingParams)

% stitch the trajectories together

    % store fly data in temporary variable and empty

    tmpFly = self.fly;

    self.fly = [];

    self.fliesN = 0;

   

    % get the start and end times for each trajectory

    startTimes = [];

    endTimes = [];

    for i=1:length(tmpFly)

        startTimes(i) = tmpFly{i}.T(1);

        endTimes(i) = tmpFly{i}.T(end);

    end

       

    % try and stitch trajectories

    replaced = zeros(length(tmpFly),1); 

    allDone = 0;

     

    while allDone == 0

        allDone = 1;

        for i=1:length(tmpFly)

            if replaced(i) == 0

                currentEnd = endTimes(i);

                toStitch = find(startTimes>=currentEnd,1,'first');

                if ~isempty(toStitch) && replaced(toStitch) == 0 && (startTimes(toStitch)-currentEnd < 1)

                    replaced(toStitch) = 1;

                    allDone = 0;

                    tmp = tmpFly{toStitch}.T;

                    tmpFly{i}.T(end+1:end+length(tmp)) = tmp;

                         

                    tmp = tmpFly{toStitch}.X;

                    tmpFly{i}.X(end+1:end+length(tmp)) = tmp;

                        

                    tmp = tmpFly{toStitch}.Y;

                    tmpFly{i}.Y(end+1:end+length(tmp)) = tmp;

                   

                    tmp = tmpFly{toStitch}.Theta;

                    tmpFly{i}.Theta(end+1:end+length(tmp)) = tmp;

                       

                    endTimes(i) = endTimes(toStitch);

                       

                end

            end

        end

    end

       

    for i=1:length(tmpFly)

        if replaced(i) == 0

            self.fliesN = self.fliesN+1;

            self.fly{self.fliesN} = trajectory.main(arenaParams,stimulusParams);

            self.fly{self.fliesN}.T = tmpFly{i}.T;

            self.fly{self.fliesN}.X = tmpFly{i}.X;

            self.fly{self.fliesN}.Y = tmpFly{i}.Y;

            self.fly{self.fliesN}.Theta = tmpFly{i}.Theta;

        end

    end

   

end

 

% Utility functions

% -------------------------------------------------------------------------

function select(self, crit, params)

% select flies depending on the criterium and its associated parameters

% Criteria:

% - "All" [no params]: select all flies

% - "None" [no params]: deselect all flies

% - "Start Position" [params.radius]: only keep flies which start within
% radius 

% - "Start Time" [params.time]: only keep flies which start prior to time

% - "Radius Crossing" [params.radius, params.time, params.direction]: only

%   keep flies which cross the radius within time and in the direction.

% - "Existence at Time" [params.time]: only keep flies which exist at time

% - "Lifetime" [params.lifetime]: only keep flies that have relative

% lifetime during trial

% - "Pathlength" [params.pathlength, params.time]: only keep flies that have >=

% pathlength within time

% - start theta [params.theta,params.delta]: only keep flies that face in

% direction at start of trajectory.

% - "Initial Walking Direction" [params.mean_theta, params.delta_theta, params.tIn]:

% only keep flies that (mean) initially walk in certain direction.

 

switch crit

    case {'All'}

        self.selectedFlies = 1:self.fliesN;

        self.selectedFliesN = length(self.selectedFlies);

    case {'None'}

        self.selectedFlies = [];

        self.selectedFliesN = 0;

    case {'Start Position'}

        newSelection = [];

        for i=1:self.selectedFliesN

            if self.fly{self.selectedFlies(i)}.Dist2Center(1) <= params.radius

                newSelection = [newSelection self.selectedFlies(i)];

            end

        end

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

    case {'Start Time'}

        newSelection = [];

        for i=1:self.selectedFliesN

            if self.fly{self.selectedFlies(i)}.T(1) <= params.time

                newSelection = [newSelection self.selectedFlies(i)];

            end

        end

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

    case {'Radius Crossing'}

        newSelection = [];

         for i=1:self.selectedFliesN

            if strcmp(params.direction,'outwards')

                ptr = find(self.fly{self.selectedFlies(i)}.Dist2Center>=params.radius & (self.fly{self.selectedFlies(i)}.Theta2Center >=pi/2 | self.fly{self.selectedFlies(i)}.Theta2Center <= -pi/2) & self.fly{self.selectedFlies(i)}.T<=params.time,'1','first');

                if ~isempty(ptr)

                    newSelection = [newSelection self.selectedFlies(i)];

                end

            else

                ptr = find(self.fly{self.selectedFlies(i)}.Dist2Center>=params.radius & (self.fly{self.selectedFlies(i)}.Theta2Center <=pi/2 | self.fly{self.selectedFlies(i)}.Theta2Center >= -pi/2) & self.fly{self.selectedFlies(i)}.T<=params.time,'1','first');

                if ~isempty(ptr)

                    newSelection = [newSelection self.self.selectedFlies(i)];

                end

            end

         end

         self.selectedFlies = newSelection;

         self.selectedFliesN = length(self.selectedFlies);

    case {'Existence at Time'}

        newSelection = [];

        for i=1:self.selectedFliesN

            ptr = find(self.fly{self.selectedFlies(i)}.T>=params.time,1,'first');

            if ~isempty(ptr)

                newSelection = [newSelection self.selectedFlies(i)];

            end

        end

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

   case {'Lifetime'}

        newSelection = [];

        for i=1:self.selectedFliesN

            if length(self.fly{self.selectedFlies(i)}.T)/self.trial_duration >= params.lifetime

                newSelection = [newSelection self.selectedFlies(i)];

            end

        end

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

    case {'Pathlength'}

        newSelection = [];

        for i=1:self.selectedFliesN

            ptr = find(self.fly{self.selectedFlies(i)}.T>=params.time,1,'first');

            if ~isempty(ptr) && self.fly{self.selectedFlies(i)}.WalkingDistance(ptr) >= params.pathlength

                newSelection = [newSelection self.selectedFlies(i)];

            end

        end

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

    case {'Start Theta'}

        newSelection = [];

        % create boundaries

        minBound = unwrap(params.theta-params.delta);

        maxBound = unwrap(params.theta+params.delta);

       

        if minBound > maxBound

           tmp = minBound;

           minBound = maxBound;

           maxBound = tmp;

        end

        for i=1:self.selectedFliesN

            if self.fly{self.selectedFlies(i)}.Theta(2)<=maxBound && self.fly{self.selectedFlies(i)}.Theta(1)>=minBound

                newSelection = [newSelection self.selectedFlies(i)];

            end

        end

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

    case {'Initial Walking Direction'}

        newSelection = [];

       

        % create boundaries

        minBound = unwrap(params.mean_theta-params.delta_theta);

        maxBound = unwrap(params.mean_theta+params.delta_theta);

       

        if minBound > maxBound

           tmp = minBound;

           minBound = maxBound;

           maxBound = tmp;

        end

       

        for i=1:self.selectedFliesN

            indx = find(self.fly{self.selectedFlies(i)}.T >= params.tIn & self.fly{self.selectedFlies(i)}.T < params.tIn+0.1,1,'first');

            if ~isempty(indx)

                deltaX = self.fly{self.selectedFlies(i)}.X(indx) - self.fly{self.selectedFlies(i)}.X(1);

                deltaY = self.fly{self.selectedFlies(i)}.Y(indx) - self.fly{self.selectedFlies(i)}.Y(1);

               

                currTheta = atan2(deltaY,deltaX);

               

                if currTheta <= maxBound && currTheta >= minBound

                    newSelection = [newSelection self.selectedFlies(i)];

                end

            end

        end

       

        self.selectedFlies = newSelection;

        self.selectedFliesN = length(self.selectedFlies);

end

end

function out = timestamps(self)

%TIMESTAMPS returns a list of all timestamps existing in trial.

%    This is a dirty workaround to get the number of frames in a trial

%    without having to interact with the database. This could also be

%    solved differently by adding a general property to the trial, but this

%    seems sufficient.

out = [];  

for i = 1:self.fliesN           

    % add timestamps that are not yet in T using set union

    % T U t_fly

    out = union(out,self.fly{i}.T);

end

out = out(~isnan(out));

end

function out = trial_duration(self)

%TRIAL_LENGTH

%    estimates the length of the trial by getting the length of the

%    timestamps array calculated.

%

% Nikolay Kladt, Janelia Farm Research Campus

% Reiserlab, February 2011

%  

 

out = length(self.timestamps());

end

   

 

% Analysis functions

% -------------------------------------------------------------------------

 

 

function [distr,n] = edge_distribution_at_time(self, param, arenaRadius, edgeDef, t0)

% EDGE_DISTRIBUTION_AT_TIME

%   calculate the distribution of a walking parameter based on flies at a timepoint t0 that are

%   currently at the edge of the arena as defined by the inputs.

%   return the values of parameters for the given flies and the number of

%   flies (length(distr)).

    distr = [];

    for i=1:self.selectedFliesN

        % check whether current fly exists in time-range

        indx = find(self.fly{self.selectedFlies(i)}.T >= t0 & self.fly{self.selectedFlies(i)}.T < t0+0.25,1,'first');

        if ~isempty(indx)

            % check whether current fly is at the edge in time range (and current value is not NaN or Inf).

            if self.fly{self.selectedFlies(i)}.Dist2Center(indx) >= edgeDef*arenaRadius & ~isinf(self.fly{self.selectedFlies(i)}.Dist2Center(indx)) & ~isnan(self.fly{self.selectedFlies(i)}.Dist2Center(indx))

                distr(end+1) = eval(['self.fly{self.selectedFlies(i)}.' param '(indx)']);

            end

        end

    end

    n = length(distr);

end

 

 

function [straight,up,down] = categorized_turning_rates(self, t0, t1, pathLength)

   % analzye the categorized turning rate of flies walking around

   % returns relative numbers (percentage) of times we see a straight walk

   % within pathlength, or a turn up or down.

   

   % angle-deviations for categorization

   straightAngleMax = pi/3; % a deviation of this or less is considered a straight walk everything above/below a turn up/down

  

   straight = 0;

   up = 0;

   down = 0;

  

   for i=1:self.selectedFliesN

      indx = find(self.fly{self.selectedFlies(i)}.T >= t0 & self.fly{self.selectedFlies(i)}.T < t1);

     

      if ~isempty(indx)

         % we have a fly to look at

         % chop the trajectory into blocks of pathLength, and look at every

         % block start heading and end-heading

         startPath = self.fly{self.selectedFlies(i)}.WalkingDistance(indx(1));

         endPath = self.fly{self.selectedFlies(i)}.WalkingDistance(indx(end));

        

         currPathLength = endPath-startPath;

         if currPathLength > pathLength

             % we have at least one block to look at

           

             numBlocks = floor(currPathLength/pathLength);

             currPath = startPath;

             for ii=1:numBlocks

                 % first determine that the fly within the block never

                 % reached the edge!

                

                 

                 

                 ix1 = find(self.fly{self.selectedFlies(i)}.WalkingDistance >= currPath,1,'first');

                ix2 = find(self.fly{self.selectedFlies(i)}.WalkingDistance >= currPath+pathLength,1,'first');

                edgeIndx = find(self.fly{self.selectedFlies(i)}.Dist2Center(ix1:ix2) > 0.85*63.5);

                 if isempty(edgeIndx)

                % get the  heading

                startHeading = self.fly{self.selectedFlies(i)}.Theta2(ix1);

                endHeading = self.fly{self.selectedFlies(i)}.Theta2(ix2);

%                 [r,a] = circ_mean(self.fly{self.selectedFlies(i)}.Theta2(ix1:ix2));

%                 endHeading = a;

                % make deltaHeading the mean walking direction

%                 deltaHeading = atan2((self.fly{self.selectedFlies(i)}.Y(ix2)-self.fly{self.selectedFlies(i)}.Y(ix1)),(self.fly{self.selectedFlies(i)}.X(ix2)-self.fly{self.selectedFlies(i)}.X(ix1)));

%                 deltaHeading = endHeading-startHeading;

                    deltaHeading = circ_rotate(endHeading,-startHeading);

                   

                currPath = currPath+pathLength;

               

                % determine whether fly was heading straight, up or down.

                if abs(deltaHeading) < straightAngleMax || abs(deltaHeading) > pi+straightAngleMax

                   straight = straight+1;

                  

                else

%                     mod(endHeading-startHeading,pi)

                    if endHeading >= 0 & endHeading < pi

                        % turn up

                        up = up+1;

%                            hold on

%                           plot(self.fly{self.selectedFlies(i)}.X(ix1),self.fly{self.selectedFlies(i)}.Y(ix1),'s')

%                         plot(self.fly{self.selectedFlies(i)}.X(ix1:ix2),self.fly{self.selectedFlies(i)}.Y(ix1:ix2))

%                         pause(0.1)

                    else

                       down = down+1;

                     

                    end

                end

                 end

             end

            

         end

        

         

         

      end

      

   end

end

function [p, n] = center_edge_probability(self, edge_dist, t1, t2)

% calculate the probability of each fly being in the center or close to the

% edge for a given time-window. returns a number between 0 and 1. One being

% totally on the edge and zero fly being totally in the center all the

% time.

%

% p: probability of being on the edge of the arena

% n: number of flies that went into the analysis

% initialize output

p = 0;

n = 0;

 

% for each timepoint from t1 to t2, calculate the percent of currently

% selected flies at the edge versus the center.

    centerCt = 0;

    edgeCt = 0;

   for ii=1:self.selectedFliesN

       indx = find(self.fly{self.selectedFlies(ii)}.T >= t1 & self.fly{self.selectedFlies(ii)}.T < t2,1,'first');

        if ~isempty(indx)

            if self.fly{self.selectedFlies(ii)}.Dist2Center(indx)>=edge_dist

               edgeCt = edgeCt+1;

            else

                centerCt = centerCt+1;

            end

        end

   end

  

   p = edgeCt/(edgeCt+centerCt);

 

end

function [p, n, dur] = zone_up_analysis(self, edge_dist, t1, t2, zoneID)

% calculate the probability of flies leaving the up zone after entering

% (within time-sman t1 t2)

n = 0;

    p = [];

    dur = [];

for i=1:self.selectedFliesN

    % does it exist in the timewindow?

    indx = find(self.fly{self.selectedFlies(i)}.T >= t1 & self.fly{self.selectedFlies(i)}.T < t2);

%     if ~isempty(indx)

    if self.fly{self.selectedFlies(i)}.T(1) <= t1+1 & self.fly{self.selectedFlies(i)}.T(end) >= t2-1

        % increase the number of flies in the analysis

      

 

        % smooth data we are working with to eliminate a fly hopping in and

        % out of a zone just by jitter...

        t = smooth(self.fly{self.selectedFlies(i)}.T(indx),15);

        rho = smooth(self.fly{self.selectedFlies(i)}.Dist2Center(indx),15);

        theta = smooth(self.fly{self.selectedFlies(i)}.Theta2Center(indx),15);

       

        % initialize zone_data array with NaNs

        zone_data = ones(length(indx),1).*NaN;

       

        % transform to zone-data for the fly

        center_zone_index = rho < edge_dist;

        zone_data(center_zone_index) = 5;

       

        edge_zones_index = find(rho >= edge_dist);

        for j=1:length(edge_zones_index)

             if theta(edge_zones_index(j)) >= pi/4 & theta(edge_zones_index(j)) < 3/4*pi

                % zone 1

                if zoneID == 1

                    zone_data(edge_zones_index(j)) = 1;

                else

                    zone_data(edge_zones_index(j)) = 2;

                end

            elseif theta(edge_zones_index(j)) >= 3/4*pi | theta(edge_zones_index(j)) < -3/4*pi

                 % zone 2

                if zoneID == 2

                    zone_data(edge_zones_index(j)) = 1;

                else

                    zone_data(edge_zones_index(j)) = 2;

                end

            elseif theta(edge_zones_index(j)) >= -pi/4 & theta(edge_zones_index(j)) < pi/4

                % zone 3

                if zoneID == 3

                    zone_data(edge_zones_index(j)) = 1;

                else

                    zone_data(edge_zones_index(j)) = 2;

                end

            elseif theta(edge_zones_index(j)) >= -3/4*pi & theta(edge_zones_index(j)) < -pi/4

                % zone 4

                if zoneID == 4

                    zone_data(edge_zones_index(j)) = 1;

                else

                    zone_data(edge_zones_index(j)) = 2;

                end

            end

        end

       

        

       

       

        

        % get the time spent in each zone and the transitions

    if zone_data(1) ~= 1 % ok , this might be interesting to remove or add both as output -> is a fly allowed to be in the zone initially or not...

      

        % find the first time you enter zone 1 and then make a new index

        % for zone data from that time to that + 10*15 (max)

       

        newIx = find (zone_data==1,1,'first');

        if length(zone_data(newIx:end))<= newIx+15*15

           zone_data = zone_data(1:end);

        else

           zone_data = zone_data(1:newIx+15*15);

        end

       

        

        A = full(sparse(zone_data(1:end-1),zone_data(2:end),1,5,5));

        % see whether fly actually enters zone 1:

        if A(1,1) > 0

             n = n+1;

            p(end+1) = sum(A(2:end,1))-sum(A(1,2:end));

            dur(end+1) = length(find(zone_data==zoneID));

        end

    end

    end

end

end

 

function [x,y] = initial_position(self)

   for i=1:self.selectedFliesN

      x(i) = self.fly{self.selectedFlies(i)}.X(1);

      y(i) = self.fly{self.selectedFlies(i)}.Y(1);

   end

end

 

function [transition_matrix, n] = zone_transition_matrix(self, edge_dist, t1, t2)

% calculate the transition matrix for the arena divided into 5 zones: a

% center zone and 4 symmetrically arranged edge_zones - each pi/2 size.

% params.radius = 35;

% self.select('Start Position',params);

% initialize output

transition_matrix = zeros(5,5);

n = 0;

% look at each currently selected fly

for i = 1:self.selectedFliesN

    % does it exist in the timewindow?

    indx = find(self.fly{self.selectedFlies(i)}.T >= t1 & self.fly{self.selectedFlies(i)}.T < t2);

   

    if ~isempty(indx)

        % increase the number of flies in the analysis

        n = n+1;

      

        % smooth data we are working with to eliminate a fly hopping in and

        % out of a zone just by jitter...

        t = smooth(self.fly{self.selectedFlies(i)}.T(indx),15);

        rho = smooth(self.fly{self.selectedFlies(i)}.Dist2Center(indx),15);

        theta = smooth(self.fly{self.selectedFlies(i)}.Theta2Center(indx),15);

       

        % initialize zone_data array with NaNs

        zone_data = ones(length(indx),1).*NaN;

       

        % transform to zone-data for the fly

        center_zone_index = rho < edge_dist;

        zone_data(center_zone_index) = 5;

       

        edge_zones_index = find(rho >= edge_dist);

        for j=1:length(edge_zones_index)

             if theta(edge_zones_index(j)) >= pi/4 & theta(edge_zones_index(j)) < 3/4*pi

                % zone 1

                zone_data(edge_zones_index(j)) = 1;

            elseif theta(edge_zones_index(j)) >= 3/4*pi | theta(edge_zones_index(j)) < -3/4*pi

                 % zone 2

                zone_data(edge_zones_index(j)) = 2;

            elseif theta(edge_zones_index(j)) >= -pi/4 & theta(edge_zones_index(j)) < pi/4

                % zone 3

                zone_data(edge_zones_index(j)) = 3;

            elseif theta(edge_zones_index(j)) >= -3/4*pi & theta(edge_zones_index(j)) < -pi/4

                % zone 4

                zone_data(edge_zones_index(j)) = 4;

            end

        end

        % get the time spent in each zone and the transitions

  

        A = full(sparse(zone_data(1:end-1),zone_data(2:end),1,5,5));

        A_diag_sum = trace(A);

        A_sum = sum(A(:));

        if A_sum > A_diag_sum

            transition_matrix = transition_matrix + tril(A,-1)./(A_sum-A_diag_sum) + triu(A,1)./(A_sum-A_diag_sum);

        end

        for i=1:length(A)

            transition_matrix(i,i) = transition_matrix(i,i) + A(i,i)/A_diag_sum;

        end

       

    end

end

  

transition_matrix = transition_matrix./n;

end

 

function out = parameter_distribution(self, param, crit, varargin)

% This function returns the distribution of a trajectory parameter at a certain criterium.

% The criteria for analysis might be:

%

% - time: all selected flies existing at this time will be analyzed.

% arguments are [t1 t2], the intervall in which the first existing data

% point is used for a given fly.

%

% - radius: all selected flies that cross the radius within the time window

% [t1 t2] are used. arguments are radius, t1, t2.

out = ones(self.selectedFliesN,1).*NaN;

switch crit

    case 'time'

        t1 = varargin{1};

        t2 = varargin{2};

        

        ct = 1;

        for i=1:self.selectedFliesN

            indx = find(self.fly{self.selectedFlies(i)}.T >= t1 & self.fly{self.selectedFlies(i)}.T < t2,1,'first');

            if ~isempty(indx)

                tmp = eval(['self.fly{self.selectedFlies(i)}.' param '(indx)']);

                  tmp(isinf(tmp)) = NaN;

               out(ct) = tmp;

               ct = ct+1;

            end

        end

       

    case 'radius'

        radius = varargin{1};

        t1 = varargin{2};

        t2 = varargin{3};

       

        ct = 1;

        for i=1:self.selectedFliesN

            indx = find(self.fly{self.selectedFlies(i)}.T >= t1 & self.fly{self.selectedFlies(i)}.T < t2 & self.fly{self.selectedFlies(i)}.Dist2Center >= radius & self.fly{self.selectedFlies(i)}.Dist2Center < radius+1,1,'first');

            if ~isempty(indx)

               out(ct) = eval(['self.fly{self.selectedFlies(i)}.' param '(indx)']);

               ct = ct+1;

            end

        end

       

    case 'pathlength'

        maxPath = varargin{1};

       

        ct = 1;

        for i=1:self.selectedFliesN

            indx = find(self.fly{self.selectedFlies(i)}.WalkingDistance >= maxPath & self.fly{self.selectedFlies(i)}.WalkingDistance < maxPath+1,1,'first');

            if ~isempty(indx)

               out(ct) = eval(['self.fly{self.selectedFlies(i)}.' param '(indx)']);

               ct = ct+1;

            end

        end

end

out = out(~isnan(out));

   

end

 

 

function out = parameter_distribution_at_radius(self, param, t0, t1, radius)

% calculate the parameter distribution the first time selected flies cross

% radius. (Only makes sense if selection is useful)

% initialize output

out = ones(self.selectedFliesN,1).*NaN;

ct = 1;

for i = 1:self.selectedFliesN

     indx = find(self.fly{self.selectedFlies(i)}.T >= t0 & self.fly{self.selectedFlies(i)}.T < t1 & self.fly{self.selectedFlies(i)}.Dist2Center >= radius & self.fly{self.selectedFlies(i)}.Dist2Center < radius+1,1,'first');

     if ~isempty(indx)

        out(ct) = self.fly{self.selectedFlies(i)}.Theta2Center(indx);

        ct=ct+1;

     end

end

  

out = out(~isnan(out));

end

 

% WORKING ON THIS FUNCTION...

function [n, theta, rho, len, indx22, flyID, flag] = jump_analysis(self,t0,t1,min_dist)

% Detect jumps/falls of flies. This is based on a distance (velocity)

% threshold - if a fly crosses a distance higher within 1 frame, this is

% counted as a jump. Also, a jump can have a length of up to three frames.

 

% output: number of jumps, for each jump, length, total distance and mean

% direction of jump. Finally, output the number of jumps detected to be

% longer than 3 frames (useful for errorchecking), also the indices of the

% jumps to be used to mark the trajectories

   

patterns = {[0 1 0],[0 1 1 0],[0 1 1 1 0]};

% algorithm to detect patterns.. (right now this is simple strfind, but may

% be replaced with something quicker.

f = @strfind;

n = 0;

theta = [];

rho = [];

len = [];

indx22 = [];

flyID = [];

for i = 1:self.selectedFliesN

    indx = find(self.fly{self.selectedFlies(i)}.T >= t0 & self.fly{self.selectedFlies(i)}.T < t1);

   

    if ~isempty(indx)

        % cleanup position data (remove NaNs and INFs)

       

        x = self.fly{self.selectedFlies(i)}.X;

        y = self.fly{self.selectedFlies(i)}.Y;

        x = x(~isnan(x));

        y = y(~isnan(x));

        x = x(~isinf(x));

        y = y(~isinf(x));

       

        % calculate instant distances

        dX = diff(x);

        dY = diff(y);

        dist = sqrt(dX.^2+dY.^2);

       

        % detect jumps and create index

        jumps = dist>min_dist;

       

        if ~isempty(jumps) % we have a jump

            for ii=1:length(patterns)

                currJump = f(jumps', patterns{ii});

               

                if ~isempty(currJump)

                    for iii = 1:length(currJump)

                        currLength = length(patterns{ii})-2;

                        dX2 = x(currJump(iii)+1+currLength)-x(currJump(iii)+1);

                        dY2 = y(currJump(iii)+1+currLength)-y(currJump(iii)+1);

                        currDist = sqrt(dX2^2+dY2^2);

                        if currDist >min_dist

                       

                            n = n+1;

                   

                            len(n) = length(patterns{ii})-2;

                    flyID(n) = self.selectedFlies(i);

                    % ok, we have jump with a certain length, now calculate

                    % overall distance and theta

                   

                    

                    

                indx22(n) = currJump(iii);

                   

                    

           

                    theta(n) = atan2(dY2,dX2);

                    rho(n) = sqrt(dX2^2+dY2^2);

                   

                    

                    end

                    end

                end

            end

        end

       

    end

end

flag = 0;

    

end

 

 

 

 

 

 

 

 

 

 

function p = walking_param_distribution(self, param, t0, t1)

    ct = 1;

    for i=1:self.selectedFliesN

        indx = find(self.fly{self.selectedFlies(i)}.T >= t0 & self.fly{self.selectedFlies(i)}.T < t1,1,'first');

       

        if ~isempty(indx)

            tmp = eval(['self.fly{self.selectedFlies(i)}.' param]);

                % at first, change possible Infs (tracking artifact) to

                % NaNs (this is a dirty fix)

                tmp(isinf(tmp)) = NaN;

            p(ct) = tmp(indx);

           ct = ct+1;

        end

           

    end

end

 

 

end

   

end

 