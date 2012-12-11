function out_mat = extend_mat(mat,extend_size)

    out_mat = zeros(1,int8(numel(mat)*extend_size));
    for g = 1:extend_size
        if g == 1
            start_pos   = 1;
        else
            start_pos   = (g-1)*extend_size+1;
        end
        
        end_pos     = g*extend_size;
        
        out_mat(start_pos:end_pos) = mat;
    end

end