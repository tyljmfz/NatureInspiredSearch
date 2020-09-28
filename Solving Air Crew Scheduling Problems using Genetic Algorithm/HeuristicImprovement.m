function [total_min] = HeuristicImprovement(sum_result,con_matrix,column_cost)
numOfResultRows = size(sum_result,1);
numOfResultColumns = size(sum_result,2);
% solutionIndex = 80;
best_result = Inf;
total_min = Inf;
w_best = [];
mincount = size(con_matrix,1);
    for solutionIndex = 1:numOfResultRows
        % initialise 
        w = con_matrix * sum_result(solutionIndex,:)';
    %     w

    %     i = randi(numOfResultRows);
    %     % alpha_i is the indices of columns that cover row i
    %     alpha_i = find(sum_result(i,:)==1);
        S = 1:numOfResultColumns;
        solution = sum_result(solutionIndex,S);
    %     cost = solution * column_cost'
        I = 1:numOfResultRows;
    %    w_i = length(intersect(alpha_i,S));
        T = S;

        % DROP
        while ~isempty(T)
            j = randi(numOfResultColumns);
            T = setdiff(T,j);
            for i = 1:size(con_matrix,1)
                if w(i) >= 2
                    S = setdiff(S,j);
    %                 beta_j = find(sum_result(:,j) == 1);
    %                 for i = 1:numOfResultRows
    %                     if (ismember(i, beta_j))
                    w(i) = w(i) - 1;
    %                     end
    %                 end
                end   
            end
        end
    %     w

        % initialize
        U = [];
    %     所有未被覆盖过的row序列号集合
        for i = 1:size(con_matrix,1)
            if w(i) == 0
                U = [U;i];
            end
        end
    %     U
        V = U;
    %     V
        minValue = Inf;
        best_j = 0;

    %     % ADD
        beta_j = [];
        best_beta_j = [];
        while ~isempty(V)
            i = V(randi(length(V)));
            V = setdiff(V,i);
            % the indices of columns that cover row i
            columnSet = find(con_matrix (i,:) == 1);
            beta_j = [];
            best_beta_j = [];
            for col = 1:length(columnSet)
                columnIndex = columnSet(col);
                temp = find(con_matrix(:,columnIndex) == 1);
                beta_j = temp;
    %             each 对columnSet里的每个j进行如下验证和计算操作 
    %             选出这个set中最小的j
                if all(ismember(beta_j, U))
                    value = column_cost(j) / (length(beta_j));
                    if value < minValue
                        minValue = value;
                        best_j = j;
                        best_beta_j = beta_j;
                    end
                end
            end
             if (length(S)< 197)
                if (best_j ~= 0)
                    S = [S,best_j];
                    for row = 1:length(best_beta_j)
        %                 actualRow = con_matrix(row,:);
                        w(row) = w(row) + 1;
                    end
                    U = setdiff(U, best_beta_j);
                    V = setdiff(V, best_beta_j);
                end
             end
        end
    %     w
    %     S
        while (length(S) < size(column_cost,2))
            S = [S,best_j];
        end
        solu = sum_result(solutionIndex,S);
    %     S
        mincost = solu * column_cost';
    %     mincost
        zero = [];
        for k = 1:size(con_matrix,1)
            if w(k) == 0
                zero = [zero;k];
            end
        end
        count = length(zero);
        for k = 1:size(con_matrix,1)
            if( w(k) > 1 || count > mincount)
                break;
            else
                if mincost < total_min 
                    w_best = w;
                    total_min = mincost;
                    mincount = count;
                end
            end
        end

    end
 

