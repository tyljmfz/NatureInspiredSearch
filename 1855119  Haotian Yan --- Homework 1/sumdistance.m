
function d = sumdistance(cities)
d = 0;
for i = 1 : length(cities)
    if i <  length(cities)
        d = d + distance(cities(i,:),cities(i+1,:));
    else
        d = d + distance(cities(i,:), cities(1,:));
end

end