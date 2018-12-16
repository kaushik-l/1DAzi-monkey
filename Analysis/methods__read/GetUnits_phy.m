function [sua, mua] = GetUnits_phy(f_spiketimes, f_spikeclusters, f_clustergroups, f_clusterlocations, electrode)

cluster_locs = [];
[~,electrode_id] = MapChannel2Electrode(electrode);
spiketimes = readNPY(f_spiketimes);
cluster_ids = readNPY(f_spikeclusters);
clusters = readCSV(f_clustergroups);
if exist(f_clusterlocations,'file') % remove if clause once we have these files for all recording sessions
    cluster_locs = readtable(f_clusterlocations);
    load('waveForms.mat');
end

sua_indx = find(strcmp({clusters.label},'good'));
for i = 1:length(sua_indx)
    sua(i).tspk = spiketimes(cluster_ids == str2double(clusters(sua_indx(i)).id));
    sua(i).cluster_id = str2double(clusters(sua_indx(i)).id);
    if ~isempty(cluster_locs)
        sua(i).channel_id = table2array(cluster_locs(str2double({clusters.id}) == str2double(clusters(sua_indx(i)).id),'Ch_num'));
        sua(i).electrode_id = electrode_id(sua(i).channel_id);
        sua(i).spkwf = squeeze(mean(waveForms(str2double({clusters.id}) == str2double(clusters(sua_indx(i)).id),:,:),2));
    else
        sua(i).channel_id = [];
        sua(i).electrode_id = [];
        sua(i).spkwf = [];
    end
end

mua_indx = find(strcmp({clusters.label},'mua'));
for i = 1:length(mua_indx)
    mua(i).tspk = spiketimes(cluster_ids == str2double(clusters(mua_indx(i)).id));
    mua(i).cluster_id = str2double(clusters(mua_indx(i)).id);
    if ~isempty(cluster_locs)
        mua(i).channel_id = table2array(cluster_locs(str2double({clusters.id}) == str2double(clusters(mua_indx(i)).id),'Ch_num'));
        mua(i).electrode_id = electrode_id(mua(i).channel_id);
        mua(i).spkwf = squeeze(mean(waveForms(str2double({clusters.id}) == str2double(clusters(mua_indx(i)).id),:,:),2));
    else
        mua(i).channel_id = [];
        mua(i).electrode_id = [];
        mua(i).spkwf = [];
    end
end