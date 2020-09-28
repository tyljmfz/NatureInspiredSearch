function [total_cost, result] = Initialization(con_matrix, column_cost, N)

% number of rows
m = size(con_matrix,1);
% number of columns
n = size(con_matrix, 2);

% Initiate I to indicate all rows are not cover (I_i = 0 means the i_th row is not covered)
% U = zeros(1,m);
I = 1:m;
U = I;
% Sk is the solution, i.e., S_j=1 means the j_th column is selcted, S_j=0,
% otherwise
Sk = zeros(1,n);
result = [];
for k = 1:N
    Sk = zeros(1,n);
    U = I;
    % It terminates when all rows are covered, i.e., sum(I)=m
     while ~isempty(U)
        % Find out which rows have not been covered
    %     uncovered_rows_idx = find(U==0);  
        % randomly select an  row i in U
        i = randi(length(U));
        % alpha_i is the indices of columns that cover row i
        alpha_i = find(con_matrix(i,:)==1);

    %    randomly select a column j ¡Ê ¦Ái 
        j = alpha_i(randi(length(alpha_i)));
        
    %     ¦Âj 
        beta_j = find(con_matrix(:,j) == 1);
        K = setdiff(I, U);
        F = intersect(beta_j, K);
    %     not exist j
    
        num = length(beta_j);
        c = [];
        if isempty(F) 
            for i = 1:num
                c = [c,i];
            end
            U(:,c) = [];
            Sk(1,j) = 1;  
        else
           U(:,i) = [];
        end
     
     end
   result = [result;Sk];
end
total_cost = Sk*column_cost';
disp(['The minimum cost found by the Stochastic Greedy algorithm is: ', num2str(total_cost)]);
disp(['The solution found by the Stochastic Greedy algorithm is: ', num2str(Sk)]);
disp(Sk);
temp2 =  (con_matrix*Sk')';
best_constraint = sum(((temp2-1).^2)');
disp(['The sum of volations of the constraints is: ', num2str(best_constraint)]);