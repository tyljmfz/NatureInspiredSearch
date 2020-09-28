function [best_length, result] = simulated_annealing(inputcities)

% Initialize the iteration number.

cities = readTSP('ulysses22.tsp');
% Objective function: the total distance for the routes.
previous_distance = sumdistance(cities);
% results = zeros(max_iter,1);
% zeros(m, n);  % 生成一个m*n的零矩阵 
% results(1) = previoaus_distance;
% plot(results);
result = [];
a = 0.99;   % 温度衰减函数的参数
t0 = 97; tf = 3; t = t0;
i = 200;  % Markov链长度
num_cities = length(cities);
route = 1:num_cities;
route_new = route;
best_length = sumdistance(cities);
Length = sumdistance(cities);
best_route = route;
iter = 1;
j = 0;
 while j < 1
% 外层大循环s
    t0 = 97; tf = 3; t = t0;
    i = 200;
    route_new = route;
    cities = readTSP('ulysses22.tsp');
    best_length = sumdistance(cities);
    Length = sumdistance(cities);
    best_route = route;
    iter = 1;
    while t>=tf
        for r=1:i       % 迭代次数
                % 两交换 产生新的route_new
                ind1 = 0; ind2 = 0;
                while (ind1 == ind2)
                    ind1 = ceil(rand.*num_cities);
                    ind2 = ceil(rand.*num_cities);
                end
                if ind1 < ind2
                    route_new (1:ind1-1) = best_route(1:ind1-1);
                    route_new (ind1:ind2) = fliplr(best_route(ind1:ind2));
                    route_new (ind2+1:num_cities) = best_route(ind2+1:num_cities);
                else
                    route_new (1:ind2-1) = best_route(1:ind2-1);
                    route_new (ind2:ind1) = fliplr(best_route(ind2:ind1));
                    route_new (ind1+1:num_cities) = best_route(ind1+1:num_cities);
                end
%                 temp = route_new(ind1);
%                 route_new(ind1) = route_new(ind2);
%                 route_new(ind2) = temp;

                % 计算路径距离
                temp_cities = cities(route_new,:);
                length_new = sumdistance(temp_cities);
                if length_new < Length      
                      Length=length_new;
                      route=route_new;
                       %对最优路线和距离更新
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
        disp('最优解为：')
        disp(best_route)
        disp('最短距离：')
        disp(best_length)
        disp('最优解迭代次数：')
        disp(iter);





    
