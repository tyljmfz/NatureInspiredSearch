function [crossover_result] = CrossOver(result)
%CROSSOVER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
CrossOverResultRowsNum = size(result,1);
CrossOverResultColumnsNum = size(result,2);
crossover_result = [];
%for index = 1:10
    for i = 2: CrossOverResultRowsNum
        for index = 1:10
            changeColumn = randi(CrossOverResultColumnsNum);
            temp = result(i,changeColumn:CrossOverResultColumnsNum);
            result(i,changeColumn:CrossOverResultColumnsNum) = result(i-1,changeColumn:CrossOverResultColumnsNum);
            result(i-1,changeColumn:CrossOverResultColumnsNum) = temp;
        end
        crossover_result =  [crossover_result; result(i,:)];
    end
%end

