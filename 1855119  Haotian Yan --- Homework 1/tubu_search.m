function [twoopt_length, result] = tubu_search(cities)

cities = readTSP('ulysses22.tsp');
num_cities=size(cities,1);

TabuLength=round((num_cities*(num_cities-1)/2)^0.5);
TabuNum=100;                               
TabuList=zeros(TabuNum,num_cities); 

% best_route = zeros(1, 22);
twoopt_length = sumdistance(cities);                  
route = 1:num_cities;
route_new = route;
best_route = route;
twoopt_index = 0;
iterations = 1;
best_length = sumdistance(cities);
tabu_index = 1;
result = [];

while iterations < 2000
        ind1 = 0; ind2 = 0;
        while (ind1 == ind2 || ind1 == 1 || ind2 == 1)
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

%        temp = route_new(ind1);
%        route_new(ind1) = route_new(ind2);
%        route_new(ind2) = temp;
%       disp(route_new)

        twoopt_temp = cities(route_new,:);
        first_length = sumdistance(twoopt_temp);
        first_route = route_new;
    while twoopt_index < 6
         % 2-opt
        ind1 = 0; ind2 = 0;
        while (ind1 == ind2 || ind1 == 1 || ind2 == 1)
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
%        temp = route_new(ind1);
%        route_new(ind1) = route_new(ind2);
%        route_new(ind2) = temp;


        twoopt_temp = cities(best_route,:);
        current_length = sumdistance(twoopt_temp);
        if current_length < first_length 
            first_length = current_length
%             disp('fuzhi')
            first_route = route_new;
        end
        twoopt_index = twoopt_index + 1;
    end

    if  ismember(first_route, TabuList, 'rows')   % skip
        iterations = iterations + 1
%         disp('test'+iterations)
       % continue;
    else 
        if first_length < best_length
            best_route = first_route
            best_length = first_length
        end

        if tabu_index <= TabuNum
            TabuList(tabu_index,:) = best_route;
            tabu_index = tabu_index+1;
        else
            tabu_index = 1;                % re enter TabuList
        end
        temp_cities = cities(best_route,:);
        candidate_length= sumdistance(temp_cities);
%        disp(best_length)
%         if candidate_length < best_length 
%             best_length = candidate_length;
%             best_route = twoopt_route;
%         end
    end

    iterations = iterations + 1;
%    results(iterations) = best_length;
end

% plot(results)
disp('best_route')
disp(best_route)
disp('best_length')
disp(best_length)
disp('iterations')
disp(iterations)
        
    
