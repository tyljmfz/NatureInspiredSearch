function [penalty] = gx(result,i)
%GX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
resultRowsNum = size(result,1);
costSet = [];
% for i = 1:resultRowsNum
solution = result(i,:);
solution_column = find(solution==1);
solution_column_set = result(:,solution_column);
sum_solution_set = sum(solution_column_set,2);
reduce_sum_solution_set = sum_solution_set - 1;
penalty = reduce_sum_solution_set' * reduce_sum_solution_set;
% end

