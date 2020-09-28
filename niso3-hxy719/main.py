#!/usr/bin/env python
# coding: utf-8

# In[1]:


import evaluation as f
from sexpdata import *

import io
import math
import fire
from pathlib import Path
import numpy as np
import csv

def niso_lab3(question, n, x, expr):
    if question == 1:
        new_x = [float(i) for i in x.split()];
        if n != len(new_x):
            return 0;
        else:
            f.num = new_x;
            f.nn = n;
            w_l = f.parse_ev(expr);
            return w_l;
        
        
def readdata(filepath, n):
    with open(filepath, 'r') as f1:
        x_data = [row[0:n] for row in csv.reader(f1, delimiter = '\t')];
    with open(filepath, 'r') as f2:
        y_data = [row[n] for row in csv.reader(f2, delimiter = '\t')];
    return x_data, y_data;


# In[2]:


print(niso_lab3(1, 2, "1.0 2.0", "(max (data 0) (data 1))" ))


# In[2]:


try:
    get_ipython().system('jupyter nbconvert --to python main.ipynb')
except:
    pass


# In[ ]:




