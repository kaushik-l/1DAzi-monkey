function trials = AddLOGData(file)

count = 0;
fid = fopen(file, 'r');
eof=0; newline = 'nothingnew'; count=0;
while newline ~= -1
    %% get ground plane density
    while ~strcmp(newline(1:9),'Floor Den')
        newline = fgetl(fid);
        if newline == -1, break; end
    end
    if newline == -1, break; end
    count = count+1;
    trials(count).prs.floordensity = str2num(newline(27:34));
    % initialise
    trials(count).logical.landmark_distance = false;
    trials(count).logical.landmark_angle = false; % #$%^&&^&*^danger - change false to nan immediately
    trials(count).prs.ptb_linear = 0;
    trials(count).prs.ptb_angular = 0;
    trials(count).prs.ptb_delay = 0;
    trials(count).prs.intertrial_interval = nan;
    trials(count).logical.firefly_fullON = nan;
    trials(count).prs.stop_duration = nan;
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
end