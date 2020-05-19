function [chnl_indx,elec_indx] = MapChannel2Electrode(electrode)

switch electrode
    case 'linearprobe16'
        chnl_indx = 1:16;
        elec_indx = 1:16;
    case 'linearprobe24'
        chnl_indx = 1:24;
        elec_indx = 1:24;
    case 'linearprobe32'
        chnl_indx = 1:32;
        elec_indx = 1:32;
    case 'utah96'
        chnl_indx = 1:96;
        elec_indx = [78 88 68 58 56 48 57 38 47 28 37 27 36 18 45 17 46 8 35 16 24 7 26 6 25 5 15 4 14 3 13 2 ...
            77 67 76 66 75 65 74 64 73 54 63 53 72 43 62 55 61 44 52 33 51 34 41 42 31 32 21 22 11 23 10 12 ...
            96 87 95 86 94 85 93 84 92 83 91 82 90 81 89 80 79 71 69 70 59 60 50 49 40 39 30 29 19 20 1 9]; 
    case 'utah2x48'
        chnl_indx = 1:96;
        elec_indx = [78 88 68 58 56 48 57 38 47 28 37 27 36 18 45 17 46 8 35 16 24 7 26 6 25 5 15 4 14 3 13 2 ...
            77 67 76 66 75 65 74 64 73 54 63 53 72 43 62 55 61 44 52 33 51 34 41 42 31 32 21 22 11 23 10 12 ...
            96 87 95 86 94 85 93 84 92 83 91 82 90 81 89 80 79 71 69 70 59 60 50 49 40 39 30 29 19 20 1 9];
end