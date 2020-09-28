function [sum_result] = sumInitialization(result, column_cost);

mutation_result = mutation(result);
crossover_result = CrossOver(result);
sum_result = [result;mutation_result;crossover_result];
end

