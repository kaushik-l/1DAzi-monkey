function trials = AddLOGData(file)

count = 0;
fid = fopen(file, 'r');
eof=0; newline = 'nothingnew'; count=0;
%% check if this data was generated by replaying the stimulus movie
if strcmp(file(1:6),'replay'), replay_movie = true;
else, replay_movie = false; end
%% check for fixed ground landmark
while ~any(strcmp(newline(1:9),{'Enable Li','Floor Lif'}))
    newline = fgetl(fid);
end
% if limited lifetime is enabled (1), fixed_ground is 0
fixed_ground = [];
if strcmp(newline(1:9),'Enable Li'), fixed_ground = logical(1 - str2double(newline(18))); end
%% read speed limit for this experimental block
while ~strcmp(newline(1:13),'Joy Stick Max')
    newline = fgetl(fid);
end
v_max = str2num(newline(32:34));
newline = fgetl(fid); w_max = str2num(newline(41:44));
while newline ~= -1
    %% get ground plane density
    while ~strcmp(newline(1:9),'Floor Den')
        newline = fgetl(fid);
        if newline == -1, break; end
    end
    if newline == -1, break; end
    count = count+1;
    trials(count).prs.floordensity = str2num(newline(27:34));
    %% initialise
    trials(count).logical.landmark_distance = false;
    trials(count).logical.landmark_angle = false; % #$%^&&^&*^danger - change false to nan immediately (what if field missing from log file??)
    trials(count).prs.ptb_linear = 0;
    trials(count).prs.ptb_angular = 0;
    trials(count).prs.ptb_delay = 0;
    trials(count).prs.intertrial_interval = nan;
    trials(count).logical.firefly_fullON = nan;
    trials(count).prs.stop_duration = nan;
    trials(count).logical.replay = replay_movie;
    trials(count).prs.v_max = v_max; % cm/s (default 200) 
    trials(count).prs.w_max = w_max; % deg/s (default 90)
    trials(count).logical.landmark_fixedground = false;
    %% get landmark status, ptb velocities and ptb delay
    newline = fgetl(fid);
    if newline == -1, break; end
    if strcmp(newline(1:9),'Enable Di')
        trials(count).logical.landmark_distance = str2num(newline(26)); % 1=distance landmark was ON
        newline = fgetl(fid);
        trials(count).logical.landmark_angle = str2num(newline(25)); % 1=angular landmark was ON
        newline = fgetl(fid);
        trials(count).prs.ptb_linear = str2num(newline(35:end)); % amplitude of linear velocity ptb (cm/s)
        newline = fgetl(fid);
        trials(count).prs.ptb_angular = str2num(newline(37:end)); % amplitude of angular velocity ptb (deg/s)
        newline = fgetl(fid);
        trials(count).prs.ptb_delay = str2num(newline(31:end)); % time after trial onset at which to begin ptb
        newline = fgetl(fid);
    end
    %% get inter-trial interval and firefly status
    if newline == -1, break; end
    if strcmp(newline(1:9),'Inter-tri')
        trials(count).prs.intertrial_interval = str2num(newline(27:end)); % time between end of this trial and beg of next trial (s)
        newline = fgetl(fid);
        trials(count).logical.firefly_fullON = str2num(newline(18)); % 1=firefly was ON throughout the trial
        newline = fgetl(fid);
    end    
    %% get stopping duration for reward
    if newline == -1, break; end
    if strcmp(newline(1:8),'Distance')
        trials(count).prs.stop_duration = str2num(newline(34:end))/1000; % wait duration after stopping before monkey is given feedback (s)
    end
    %% check for fixed ground
    if newline == -1, break; end
    if isempty(fixed_ground)
        while ~strcmp(newline(1:9),'Enable Li')
            newline = fgetl(fid);
        end
        fixed_ground = logical(1 - str2double(newline(18)));
    end
    trials(count).logical.landmark_fixedground = fixed_ground;
end

%% close file
fclose(fid);