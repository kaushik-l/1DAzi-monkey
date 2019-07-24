classdef session < handle
    %%
    properties
        monk_id
        sess_id
        coord
        behaviours = behaviour.empty();                                     % trial
        units = unit.empty();                                               % single/multiunit
        lfps = lfp.empty();% lfp
        lfps_plx = lfp.empty();% lfp U-Probes
        lfps_nev = lfp.empty(); % lfp utah array
        populations = population.empty();                                   % population
    end
    %%
    methods
        %% class constructor
        function this = session(monk_id,sess_id,coord)
            this.monk_id = monk_id;
            this.sess_id = sess_id;
            this.coord = coord;
        end
    end
end