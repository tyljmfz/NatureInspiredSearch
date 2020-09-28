function [cities] = readTSP(inputfile)
cities = zeros(22,2,'double');
input = fopen(inputfile);
while ~feof(input)
    tline = fgetl(input);
    arrs = strsplit(tline);
    arrs2 = char(arrs);
    if arrs2(1,:) == ' '
        index = str2num(arrs2(2,:));
        cities(index,1) = str2double(arrs2(3,:));
        cities(index,2) = str2double(arrs2(4,:));
    else
        continue
    end
end
fclose(input);
end


