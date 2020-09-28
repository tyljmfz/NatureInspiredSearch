#!/usr/bin/env python
# coding: utf-8

# In[2]:


from sexpdata import *

import io
import math
import fire
from pathlib import Path
import numpy as np
import csv

num = [];
nn = 0;

def parse_ev(expression):
    exp = loads(expression);
    return evaluate(exp);

def evaluate(expression):
    if value_type(expression):
        return expression;

    if expression[0] == Symbol('add'):
        return eval_add(expression[1], expression[2]);

    if expression[0] == Symbol('sub'):
        return eval_sub(expression[1], expression[2]);

    if expression[0] == Symbol('mul'):
        return eval_mul(expression[1], expression[2]);

    if expression[0] == Symbol('div'):
        return eval_div(expression[1], expression[2]);

    if expression[0] == Symbol('pow'):
        return eval_pow(expression[1], expression[2]);

    if expression[0] == Symbol('sqrt'):
        return eval_sqrt(expression[1]);

    if expression[0] == Symbol('log'):
        return eval_log(expression[1]);

    if expression[0] == Symbol('exp'):
        return eval_exp(expression[1]);

    if expression[0] == Symbol('max'):
        return eval_max(expression[1], expression[2]);

    if expression[0] == Symbol('data'):
        return eval_data(expression[1]);

    if expression[0] == Symbol('ifleq'):
        return eval_fleq(expression[1], expression[2], expression[3], expression[4]);

    if expression[0] == Symbol('diff'):
        return eval_diff(expression[1], expression[2]);

    if expression[0] == Symbol('avg'):
        return eval_avg(expression[1], expression[2]);


def eval_add(a,b):
    if value_type(a) and value_type(b):
        return a+b;
    if not value_type(a) and value_type(b):
        return eval_add(evaluate(a),b);
    if value_type(a) and not value_type(b):
        return eval_add(a, evaluate(b));
    else:
        return eval_add(evaluate(a), evaluate(b));
        
def eval_sub(a,b):
    if value_type(a) and value_type(b):
        return a-b;
    if not value_type(a) and value_type(b):
        return eval_sub(evaluate(a),b);
    if value_type(a) and not value_type(b):
        return eval_sub(a, evaluate(b));
    else:
        return eval_sub(evaluate(a), evaluate(b));
    
def eval_mul(a,b):
    if value_type(a) and value_type(b):
        return a*b;
    if not value_type(a) and value_type(b):
        return eval_mul(evaluate(a),b);
    if value_type(a) and not value_type(b):
        return eval_mul(a, evaluate(b));
    else:
        return eval_mul(evaluate(a),  evaluate(b));
        
        
def eval_div(a,b):
    if value_type(a) and value_type(b):
        if b == 0:
            return 0;
        else:
            return a/b;
            
    if not value_type(a) and value_type(b):
        if b == 0:
            return 0;
        else:
            return eval_div(evaluate(a), b);
        
    if value_type(a) and not value_type(b):
        return eval_div(a, evaluate(b));
    else:
        return eval_div(evaluate(a), evaluate(b));
    
def eval_pow(a,b):
    if value_type(a) and value_type(b):
        if a == 0:
            return 0
        else:
            try:
                res = a ** b;
                if not isinstance(res, complex):
                    return res;
                else:
                    return 0;
            except OverflowError or ValueError:
                return 0;
            except ValueError:
                return 0;
    if not value_type(a) and value_type(b):
        if evaluate(a) == 0:
            return 0;
        else:
            try:
                res = evaluate(a) ** b;
                if not isinstance(res, complex):
                    return res;
                else:
                    return 0;
            except OverflowError or ValueError:
                return 0;
            except ValueError:
                return 0;
    if value_type(a) and not value_type(b):
        if evaluate(b) == 0:
            return 0;
        else:
            try:
                res = a ** evaluate(b);
                if not isinstance(res, complex):
                    return res;
                else:
                    return 0;
            except OverflowError or ValueError:
                return 0;
            except ValueError:
                return 0;

    else:
        e1 = evaluate(a);
        e2 = evaluate(b);
        if e1 == 0:
            return 0;
        else:
            try:
                res = e1 ** e2;
                if not isinstance(res, complex):
                    return res;
                else:
                    return 0
                #return e1 ** e2;
            except OverflowError or ValueError:
                return 0;
            except ValueError:
                return 0;
        
        
def eval_sqrt(a):
    if value_type(a):
        if a > 0:
            try:
                return math.sqrt(a);
            except ValueError or OverflowError:
                return 0;
        else:
            return 0;
    else:
        return evaluate(a);
        
def eval_log(a):
    if value_type(a):
        if a > 0:
            return math.log(a, 2);
        else:
            return 0;
    else:
        return evaluate(a);
        
        
def eval_exp(a):
    if value_type(a):
        try:
            return  math.exp(a);
        except OverflowError:
            return  float(0);
    else:
        try:
            return eval_exp(evaluate(a));
        except OverflowError:
            return  float(0);
        
def eval_max(a,b):
    if value_type(a) and value_type(b):
        return max(a,b);
    if not value_type(a) and value_type(b):
        return eval_max(evaluate(a),b);
    if value_type(a) and not value_type(b):
        return eval_max(a, evaluate(b));
    else:
        return eval_max(evaluate(a),  evaluate(b));
        
        
def eval_data(a):
    if value_type(a):
        ind = mod(a, nn);
        if ind != 0:
            return num[ind];
        else:
            return 0;
    else:
        return eval_data(evaluate(a));
        
def mod(x , y): 
    if int(y) == 0:
        return 0;
    else:
        try:
            return int(divmod(int(x), int(y))[1]);
        except OverflowError or ValueError:
            return 0;
        
        
def eval_fleq(a,b,c,d):
    if eval_max(evaluate(a), evaluate(b)) == evaluate(b): 
        # a < b
        return evaluate(c);
    else:
        return evaluate(d);
        

def eval_diff(a,b):
    if value_type(a) and value_type(b):
        return eval_sub(eval_data(a), eval_data(b));
    if not value_type(a) and value_type(b):
        return eval_diff(evaluate(a), b);
    if value_type(a) and not value_type(b):
        return eval_diff(a, evaluate(b));
    else:
        return eval_diff(evaluate(a),  evaluate(b));
        
        
def eval_avg(a,b):
    if value_type(a) and value_type(b):
        a_mod = mod(a, nn);
        b_mod = mod(b, nn);
        temp = math.fabs(a_mod - b_mod);
        small = min(a_mod, b_mod);
        large = max(a_mod, b_mod);
        if temp == 0:
            return 0;
        else:
            if small == large:
                return num[eval_data(a_mod)-b_mod];
            else:
                return eval_div(sum(num[small: large - 1]), temp);

    if not value_type(a) and value_type(b):
        return eval_avg(evaluate(a), b);
    if value_type(a) and not value_type(b):
        return eval_avg(a, evaluate(b));
    else:
        return eval_avg(evaluate(a),  evaluate(b));

        
def value_type(a):
    if isinstance(a, int) or isinstance(a, float):
        return True;
    else:
        return False;
        
        
        





# In[3]:


parse_ev(  "(data 1)")


# In[3]:


try:
    get_ipython().system('jupyter nbconvert --to python evaluation.ipynb')
except:
    pass


# In[ ]:




