import re
import os
import pickle

get_ipython().run_line_magic('precision', 5)
get_ipython().run_line_magic('load_ext', 'autoreload')
# %load_ext autoreload

try:
    import numpy as np
    from PIL import Image
    import pandas as pd
    from matplotlib import pyplot as plt
    np.set_printoptions(precision=5, floatmode='fixed', suppress=True)
except ImportError as e:
    print(e)

try:
    from torch import nn
except ImportError as e:
    print(e)

# %config IPCompleter.use_jedi = False
# ipython profile create
# edit /home/ken/.ipython/profile_default/ipython_config.py
