function [mutation_result] = mutation(result)
%MUTATION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

