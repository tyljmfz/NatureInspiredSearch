function [mincost] = fx(result,column_cost,i)
%FX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
resultRowsNum = size(result,1);
costSet = [];
% for i = 1:resultRowsNum
solution = result(i,:);
cost_column = column_cost';
mincost = solution * cost_column;
%    costSet = [costSet;mincost];
% end


