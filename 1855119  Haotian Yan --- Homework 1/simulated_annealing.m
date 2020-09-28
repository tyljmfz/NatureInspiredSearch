function [best_length, result] = simulated_annealing(inputcities)

% Initialize the iteration number.

cities = readTSP('ulysses22.tsp');
% Objective function: the total distance for the routes.
previous_distance = sumdistance(cities);
% results = zeros(max_iter,1);
% zeros(m, n);  
% results(1) = previoaus_distance;
% plot(results);
result = [];
a = 0.99;   % parameter
t0 = 97; tf = 3; t = t0;
i = 2000;  % iter
num_cities = length(cities);
route = 1:num_cities;
route_new = route;
best_length = sumdistance(cities);
Length = sumdistance(cities);
best_route = route;
iter = 1;
j = 0;
 while j < 30
    t0 = 97; tf = 3; t = t0;
    i = 2000;
    route_new = route;
    cities = readTSP('ulysses22.tsp');
    best_length = sumdistance(cities);
    Length = sumdistance(cities);
    best_route = route;
    iter = 1;
    while t>=tf
        for r=1:i       % iter
                % 2-opt
                ind1 = 0; ind2 = 0;
                while (ind1 == ind2)
                    ind1 = ceil(rand.*num_cities);
                    ind2 = ceil(rand.*num_cities);
                end
                if ind1 < ind2
                    route_new (2:ind1-1) = best_route(2:ind1-1);
                    route_new (ind1:ind2) = fliplr(best_route(ind1:ind2));
                    route_new (ind2+1:num_cities) = best_route(ind2+1:num_cities);
                else
                    route_new (2:ind2-1) = best_route(2:ind2-1);
                    route_new (ind2:ind1) = fliplr(best_route(ind2:ind1));
                    route_new (ind1+1:num_cities) = best_route(ind1+1:num_cities);
                end
%                 temp = route_new(ind1);
%                 route_new(ind1) = route_new(ind2);
%                 route_new(ind2) = temp;

                % calculate the length
                temp_cities = cities(route_new,:);
                length_new = sumdistance(temp_cities);
                if length_new < Length      
                      Length=length_new;
                      route=route_new;
                       %update best
                       if  length_new<best_length
                                iter = iter + 1;    
                                best_length=length_new;
                                best_route=route_new;
                       end
                else
                       if rand<exp(-(length_new-Length)/t)
                          route=route_new;
                          Length=length_new;
                       end
                end
                    route_new=route; 
        end
        t = t*a;
        
    end 
    result = [result;best_length];
    j = j + 1;
 end
Route=[best_route best_route(1)];
        disp('best_route')
        disp(best_route)
        disp('best_length')
        disp(best_length)
        disp('iter')
        disp(iter);





    
