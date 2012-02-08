function epochGroup = ImportJayaramanTrials(epochGroup, trials)
    
    % Copyright (c) 2012 Physion Consulting LLC
    
    
    disp('Importing Epochs...');
    for i = 1:length(trials)
        
        if(mod(i,5) == 0)
            disp(['    Epoch ' num2str(i) ' of ' num2str(length(trials)) '...']);
        end
        
        trial = trials(i);
        
        [epoch,xsgInserted] = insertFlyArenaEpoch(epochGroup, trial);
        
        if(isfield(trial, 'xsg') && ~xsgInserted)
            xsg = load(trial.xsg.xsgFilePath, '-mat');
            appendXSG(epoch,...
                xsg,...
                epoch.getStartTime().getZone().getID());
        end
        
        if(isfield(trial,'scanImage'))
            appendScanImageTiff(epoch,...
                trial.scanImage.scanImageTIFFPath,...
                trial.scanImage.scanImageConfigYAMLPath,...
                epoch.getStartTime().getZone().getID(),...
                true);
        end
        
        if(isfield(trial, 'seq'))
            appendSeq(epoch,...
                trial.seq.seqFilePath,...
                trial.seq.seqConfigYAMLPath);
        end
    end
    
    disp('    Done.')
   
   
end