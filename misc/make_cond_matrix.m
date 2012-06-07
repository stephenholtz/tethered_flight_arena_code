function [cond_matrix name_matrix] = make_cond_matrix(condition_function_output)
    % just pass it the output of the condition function and it makes a
    % matrix that eases difficlty of figuring out symmetric conditions!
    % make a row for each condition, and a col for a few of the params
    
    c=condition_function_output;
    for g = 1:numel(condition_function_output)
        cond_matrix(g,:) = [c(g).PatternID, c(g).InitialPosition, c(g).Mode, c(g).Gains,  c(g).PosFunctionX(2), c(g).PosFunctionY(2)];
        name_matrix{g,:} = {c(g).PatternName c(g).PosFuncNameX c(g).PosFuncNameY};
    end
end