classdef multiunit < handle
    %%
    properties
        channel_no
        spkwf
        trials
        stats
        corrgrams
    end
    %%
    methods
        %% class constructor
        function this = multiunit(unit)
            this.channel_no = []; %unit.chnl;
            this.spkwf = []; %mean(unit.spkwf);
        end
        %% add spike times
        function AddTrials(this,tspk,events_spk,prs)
            this.trials = AddTrials2Unit(tspk,events_spk,prs);
        end
        %% analyse spikes
        function AnalyseUnit(this,exp_name,behaviours,prs)
            [this.trials,this.stats] = AnalyseRates(exp_name,this.trials,behaviours.trials,behaviours.stats,prs);
%             this.weights = ComputeWeights(exp_name,this.trials,behaviours.trials,prs); % requires neuroGLM package: https://github.com/pillowlab/neuroGLM
        end
        %% destroy spike times
        function destroy_spks(this)
            this.spks = [];
            this.tspk = [];
        end
    end
end