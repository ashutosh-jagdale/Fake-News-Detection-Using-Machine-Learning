import math
import pdb
from nltk import word_tokenize
import io
import os
from sklearn.preprocessing import LabelEncoder
from nltk.stem.porter import PorterStemmer
# stop words are, is, the etc. which are not needed for model
from nltk.corpus import stopwords
import pandas as pd
import numpy as np
import xgboost as xgb
import re
import nltk
#nltk.download('stopwords')
#nltk.download('punkt')


#df = pd.read_csv('final_trail1.csv')
#df.drop(['Unnamed: 0', 'Unnamed: 0.1', 'Unnamed: 0.1.1', 'ord_in_thread', 'replies_count', 'participants_count', 'country','likes', 'comments', 'site_url', 'language', 'content', 'ord_in_thread', 'uuid', 'crawled'], axis=1, inplace=True)

#temp_published = df['published'].apply(lambda x: x[slice(10)])
#df['published'] = pd.to_datetime(temp_published, format="%Y-%M-%d")


def title_column(tuple1):
    # print(tuple1[2])
    if(type(tuple1[0]) == float or type(tuple1[0]) == int):
        if(math.isnan(tuple1[0])):
            tuple1[0] = ''

    if(pd.notna(tuple1[0])):
        if(tuple1[0].strip(' \t\n\r') == ''):
            return re.sub(r"[^A-Za-z0-9(),!?\'\`]", " ", tuple1[1])
        else:
            return re.sub(r"[^A-Za-z0-9(),!?\'\`]", " ", tuple1[0])
    else:
        return re.sub(r"[^A-Za-z0-9(),!?\'\`]", " ", tuple1[0])


def text_column(tuple1):
    # print(tuple1[2])
    if(type(tuple1[1]) == float or type(tuple1[1]) == int):
        if(math.isnan(tuple1[1])):
            tuple1[1] = ''

    if(pd.notna(tuple1[1])):
        if(tuple1[1].strip(' \t\n\r') == ''):
            return re.sub(r"[^A-Za-z0-9(),!?\'\`]", " ", tuple1[0])
        else:
            return re.sub(r"[^A-Za-z0-9(),!?\'\`]", " ", tuple1[1])
    else:
        return re.sub(r"[^A-Za-z0-9(),!?\'\`]", " ", tuple1[1])


#df['title'] = df[['title', 'text']].apply(title_column, axis=1)
#df['text'] = df[['title', 'text']].apply(text_column, axis=1)

#df["num_words"] = df["text"].apply(lambda x: len(str(x).split()))

def final_model(df):
    lb_encode = LabelEncoder()
    #df['type_num']= lb_encode.fit_transform(df['type'])
    #df['category_factor_num'] = lb_encode.fit_transform(df['category_factor'])
    #df['stance_factor_num'] = lb_encode.fit_transform(df['stance'])
    df['stance_factor_num'] = 0
    df.loc[df.stance.str.contains('discuss'), 'stance_factor_num'] = 0.3
    df.loc[df.stance.str.contains('unrelated'), 'stance_factor_num'] = 1.0
    df.loc[df.stance.str.contains('agree'), 'stance_factor_num'] = 0
    df.loc[df.stance.str.contains('disagree'), 'stance_factor_num'] = 0.8

    X = df[[ 'spam_score_fector','click_bait_score', 'category_factor_num', 'toxicity_factor','src_url_polarity','sentiment_score','stance_factor_num']]

    model_xgb_2 = xgb.XGBClassifier()
    model_xgb_2.load_model("model_sklearn.txt")

    pred = model_xgb_2.predict_proba(X)
    pred_c = pred[0][1] * 100
    return pred_c
    #rank = df['domain_rank']
    #rank = rank[0]
    #print(rank)
    #if rank!=0:
        #df['title'] = df[['title', 'text']].apply(title_column, axis=1)
        #df['text'] = df[['title', 'text']].apply(text_column, axis=1)
        #df["num_words"] = df["text"].apply(lambda x: len(str(x).split()))
        #Xr = df[[ 'domain_rank','num_words']]
        #model_xgb_r = xgb.XGBClassifier()
        #model_xgb_r.load_model("model_sklearn_dom.txt")
        #pred1 = model_xgb_r.predict_proba(Xr)
        #pred_c1 = pred1[0][1] * 100
        #avg = ((pred_c1+pred_c)/2)
        #return(avg)
        
        #return pred_c
    #else:
    
    #if pred_c >= 90: return('True')
    #elif pred_c < 90 and pred_c >= 75: return('Mostly True')
    #elif pred_c < 75 and pred_c >= 50: return('Half True')
    #elif pred_c < 50 and pred_c >= 40: return('Mostly False')
    #elif pred_c < 40 and pred_c >= 25: return('False')
    #else: return('Pants On Fire')