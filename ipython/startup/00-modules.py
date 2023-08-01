import re
import os
import pickle
from glob import glob
import itertools

get_ipython().run_line_magic('precision', 5)
get_ipython().run_line_magic('load_ext', 'autoreload')
# %load_ext autoreload

try:
    from PIL import Image
    import numpy as np
    import pandas as pd
    from matplotlib import pyplot as plt
    import timm
    import torch
    from torch import nn
    import timm

    np.set_printoptions(precision=5, floatmode='fixed', suppress=True)
    Image.MAX_IMAGE_PIXELS = 8_000_000_000
except ImportError as e:
    print(e)


# %config IPCompleter.use_jedi = False
# ipython profile create
# edit /home/ken/.ipython/profile_default/ipython_config.py
