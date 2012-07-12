function RunTS(protocol,varargin)
%RunTS will be for temperature sensitive experiments. Since starting and
%stopping them will need to be easily done/temperature should be error
%checked and displayed etc.,
%
    tID = tic;
    metadata = Exp.Utilities.do_all_protocol_checks(protocol);
    Exp.Utilities.make_metadata_gui(metadata);



    timer = toc(tID);
    fprintf('Finished in %d mins\n',timer/60);
end