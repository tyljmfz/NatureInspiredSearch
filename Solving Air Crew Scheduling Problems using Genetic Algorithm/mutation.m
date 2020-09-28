function [mutation_result] = mutation(result)
%MUTATION 此处显示有关此函数的摘要
%   此处显示详细说明
MutationResultRowsNum = size(result,1);
MutationResultColumnsNum = size(result,2);
mutation_result = [];
for i = 1: MutationResultRowsNum
    changeColumn = randi(MutationResultColumnsNum);
    if result(i,changeColumn)== 0
        result(i,changeColumn) = 1;
    else
        result(i,changeColumn) = 0;
    end
    mutation_result =  [mutation_result; result(i,:)];
end

