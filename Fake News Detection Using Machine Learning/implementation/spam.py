import string
import joblib
from sklearn.feature_extraction.text import TfidfTransformer
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
import pandas as pd
import nltk
#nltk.download('stopwords')


def spam(x):

    k = joblib.load('Spam_filename.pkl')
    output1 = k.predict_proba(x)
    ans = output1[:, 0]
    return ans[0]
