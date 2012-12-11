function outstruct = func_on_struct(struct,func)                           %#ok<*STOUT,*INUSL>
    struct = eval('struct');
    func = str2func(func);
    fields = fieldnames(struct);
    
    clear eval
    for f = 1:numel(fields)
        [m n] = eval(['size(struct.' fields{f} ');']);                      %#ok<*NASGU,*ASGLU>
        eval(['outstruct.' fields{f} '= NaN(m,n);']);
    end
    clear eval
    for f = 1:numel(fields)
        eval(['outstruct.' fields{f} '= func(struct.' fields{f} ');' ]);
    end
end