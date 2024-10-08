import re
import os
import pickle
import math
import itertools
from glob import glob

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
    import torch.nn.functional as F
    import timm

    np.set_printoptions(precision=5, floatmode='fixed', suppress=True)
    Image.MAX_IMAGE_PIXELS = 8_000_000_000
except ImportError as e:
    print(e)

def count_parameters(model):
    return sum(p.numel() for p in model.parameters() if p.requires_grad)

# %config IPCompleter.use_jedi = False
# ipython profile create
# edit /home/ken/.ipython/profile_default/ipython_config.py
