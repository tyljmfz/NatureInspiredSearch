function [total_min] = main()
%MAIN 此处显示有关此函数的摘要
%   此处显示详细说明
[con_matrix, column_cost] = ReadInData('sppnw42.dat')
[total_cost, result] = Initialization(con_matrix, column_cost, 500)
[sum_result] = sumInitialization(result, column_cost);
[sum_result] = StochasticRanking(sum_result,column_cost)
[total_min] = HeuristicImprovement(sum_result,con_matrix,column_cost)
% [w_best,total_min] = HeuristicImprovement(sum_result,con_matrix,column_cost)