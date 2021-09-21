import re
import os

from PIL import Image
import numpy as np
import pandas as pd
import torch
from torch import nn
from matplotlib import pyplot as plt


get_ipython().run_line_magic('precision', 5)
np.set_printoptions(precision=5, floatmode='fixed', suppress=True)

get_ipython().run_line_magic('load_ext', 'autoreload')
# %load_ext autoreload

# %config IPCompleter.use_jedi = False
# ipython profile create
# edit /home/ken/.ipython/profile_default/ipython_config.py
