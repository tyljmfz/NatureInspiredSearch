function [mincost] = fx(result,column_cost,i)
%FX 此处显示有关此函数的摘要
%   此处显示详细说明
resultRowsNum = size(result,1);
costSet = [];
% for i = 1:resultRowsNum
solution = result(i,:);
cost_column = column_cost';
mincost = solution * cost_column;
%    costSet = [costSet;mincost];
% end


