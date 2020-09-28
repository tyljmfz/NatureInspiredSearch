function [sum_result] = StochasticRanking(sum_result,column_cost)
%STOCHASTICRANKING �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% N = size(sum_result,1);
numOfColumns = size(sum_result,2);
rowsWhichEqualZero = [];
% ��ɾ���յĽ�
sum_result(all(sum_result==0, 2),:)=[];
N = size(sum_result,1);
for j = 1:N
    for i = 2:N
        u = normrnd(0,1);
        if gx(sum_result, i-1) == gx(sum_result,i) == 0 || u <= 0.5
            if fx(sum_result,column_cost,i-1) < fx(sum_result,column_cost,i)
                % swap I
                swapi = sum_result(i,:);
                sum_result(i,:) = sum_result(i-1,:);
                sum_result(i-1,:) = swapi;
            end
        else
            if gx(sum_result, i-1) < gx(sum_result,i)
                % swap I
                swapi = sum_result(i,:);
                sum_result(i,:) = sum_result(i-1,:);
                sum_result(i-1,:) = swapi;
            end
        end
        i = i+1;
    end
    j = j +1; 
end
    



