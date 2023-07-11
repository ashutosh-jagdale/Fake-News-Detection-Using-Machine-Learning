import pandas as pd
import numpy as np
import nltk
import re
import string
from nltk.corpus import stopwords
import pickle
from sklearn.feature_extraction.text import TfidfVectorizer


def get_caps_ratio(dfcp):
  for i,row in dfcp.iterrows():
    title=row['title']
    temp_np_title = title.strip(string.punctuation).split()
    np_title = [word.strip(string.punctuation) for word in temp_np_title]
    final_title = [word for word in np_title if word not in set(stopwords.words('english'))]
    final_title = " ".join(final_title)
    num_caps = len([elem for elem in final_title if elem.isupper()])
    num_words = len([elem for elem in final_title if elem == ' ']) + 1
    ratio = num_caps / num_words
    dfcp.loc[i,'caps_ratio']  = ratio


def get_questions(dfcp):
  for i,row in dfcp.iterrows():
    title=row['title']
    if '?' in title:
      dfcp.loc[i,'question']  = 1
    else:
      dfcp.loc[i,'question']  = 0


def get_exclamation(dfcp):
  for i,row in dfcp.iterrows():
    title=row['title']
    if '!' in title:
      dfcp.loc[i,'exclamation']  = 1
    else:
      dfcp.loc[i,'exclamation']  = 0


def convert_lower(s):
    s = s.lower()
    return s

def replace_slash(s):
    s = s.replace("/", " ")
    return s

def remove_punctuation(s):
    s = ''.join([i for i in s if i not in frozenset(string.punctuation)])
    return s

def remove_stop_words(s):
    s = ' '.join([word for word in s.split() if word.lower() not in stopwords.words('english')])
    return s


def get_log_ratio(dfcp):
    for i,row in dfcp.iterrows():
        dfcp.loc[i,'log_ratio'] = 0.7796519932677565


def clickbait(t):
    inp = t
    data = {'title':[inp]}
    dfcp = pd.DataFrame(data)
    dfcp['length']=dfcp['title'].apply(len)
    dfcp['caps_ratio'] = np.nan
    dfcp['question'] = np.nan
    dfcp['exclamation'] = np.nan
    dfcp['log_ratio'] = np.nan
    dfcp['mnb_prob'] = np.nan

    filename = 'tf.pkl'
    infile = open(filename, 'rb')
    tfidf = pickle.load(infile)
    infile.close()
    filename = 'mnb.pkl'
    infile = open(filename, 'rb')
    mnb = pickle.load(infile)
    infile.close()
    filename = 'cblr2.pkl'
    infile = open(filename, 'rb')
    logistic_regression = pickle.load(infile)
    infile.close()

    get_caps_ratio(dfcp)
    get_questions(dfcp)
    get_exclamation(dfcp)
    dfcp['cleaned_title'] = dfcp['title'].apply(convert_lower)
    dfcp['cleaned_title'] = dfcp['cleaned_title'].apply(replace_slash)
    dfcp['cleaned_title'] = dfcp['cleaned_title'].apply(remove_punctuation)
    dfcp['cleaned_title'] = dfcp['cleaned_title'].apply(remove_stop_words)
    get_log_ratio(dfcp)

    X_headline_text = dfcp['cleaned_title'].values.tolist()
    X_headline_tfidf = tfidf.transform (X_headline_text)
    output1 =  mnb.predict_proba(X_headline_tfidf)
    dfcp['mnb_prob'] = output1[0,0]

    X_t = dfcp[['caps_ratio', 'exclamation', 'question','mnb_prob']]
    output2 = logistic_regression.predict_proba(X_t)
    return output2[0,0]

print(clickbait('BREAKING: Weiner Cooperating With FBI On Hillary Email Investigation'))