function AddHandData(file,prs)

my_features = prs.hand_features;
vals = csvread(file,3,0);
[nFrames,nTags] = size(vals);
fid = fopen(file);
title = textscan(fid,'%s',3);
features = textscan(title{:}{2},'%s',nTags,'delimiter',','); features = {features{1}{:}};
headers = textscan(title{:}{3},'%s',nTags,'delimiter',','); headers = {headers{1}{:}};
fclose(fid);

my_coords = {'x','y'};
pos_hand = nan(numel(my_features),numel(my_coords),nFrames);
for i=1:numel(my_features)
    indx = vals(:,strcmp(features,my_features{i}) & strcmp(headers,'likelihood')) > 0.99;
    for j=1:numel(my_coords)
        pos_hand(i,j,indx) = vals(indx,strcmp(features,my_features{i}) & strcmp(headers,my_coords{j}));
    end
end

figure; plot(squeeze(pos_hand(1:4,1,:))',squeeze(pos_hand(1:4,2,:))','.','MarkerSize',0.25); 
axis([0 720 0 480]); set(gca,'YDir','reverse');

figure; plot(squeeze(pos_hand(1,1,:)));