classdef Project
   % PROJECT aggregates data from individual experiments across genotypes, 
   %    effectors, dates, conditions etc.,
   %    
   %    Designed to replace tfAnalysis.Genotype by allowing direct
   %    comparison of sets of conditions easily.
   %    
   %    Current plan:
   %        PROJECT will take data from tfAnalysis.Experiment objects to
   %        fill properties that will all share a common index (at least
   %        one).
   %        
   %        For now, *all* identical and flipped symmetrical (grouped)
   %        conditions will be filled in here as means (and SEMs??) per
   %        experiment. Preservation of individual trials remains confusing
   %        and needs specific processing stages.
   %        
   %        Try to use dynamic field names for conditions or condition sets
   %        
   %
   %    !No plans to push this to a database, this is for local manipulation
   %    and figure making!
   
   properties
       
   end
   
   methods
       
   end
    
end