import pickle
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import pickle as pkl
from sklearn.feature_extraction.text import CountVectorizer
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import TfidfTransformer
import joblib

# t = open('Spammodel_v1.pkl' ,'rb')
# loaded_model = pickle.load(t)
import string


def text_process(mess):
    # Check characters to see if they are in punctuation
    nopunc = [char for char in mess if char not in string.punctuation]

    # Join the characters again to form the string.
    nopunc = ''.join(nopunc)

    # Now just remove any stopwords
    return [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]


k = joblib.load('Spam_filename.pkl')
data = {'content': ['Muslims BUSTED: They Stole Millions In Govâ€šÃ„Ã´t Benefits Print They should pay all the back all the money plus interest. The entire family and everyone who came in with them need to be deported asap. Why did it take two years to bust them Here we go again â€šÃ„Â¶another group stealing from the government and taxpayers! A group of Somalis stole over four million in government benefits over just 10 months Weâ€šÃ„Ã´ve reported on numerous cases like this one where the Muslim refugees/immigrants commit fraud by scamming our systemâ€šÃ„Â¶Itâ€šÃ„Ã´s way out of control! More Related']}
df = pd.DataFrame(data)

output1 = k.predict_proba(df['content'])

df['spam-score'] = output1[:, 0]
print(output1)
