
graph.line = {(1:10),(1:10),(1:10),(1:10),(1:10)};

curr_colormap = earth(1:5);

for i = 1:numel(graph.line)
   graph.line{i} = graph.line{i} + abs((graph.line{i} * 10 * randn) .* sin(linspace(-pi*2,pi*2,10)));
   graph.shade{i} = abs(10*randn(1,10));
   graph.color{i} = squeeze(curr_colormap(:,i,:))';
   
   graph.line_width = 5;
   
end

clf

makeErrorShadedTimeseries(graph);
