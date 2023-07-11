from sklearn.feature_extraction.text import TfidfVectorizer
import joblib
# stop words are, is, the etc. which are not needed for model
from nltk.corpus import stopwords
import pandas as pd
import numpy as np
import nltk
#nltk.download('stopwords')


def classification(x):
    tfidf = TfidfVectorizer(sublinear_tf=True, min_df=5, norm='l2',
                            encoding='latin-1', ngram_range=(1, 2), stop_words='english')

    # data = {'content': [
    #     'Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt rate)T&C']}
    # df = pd.DataFrame(data)

    k = joblib.load("Classification.pkl")

    tfidf = joblib.load('Classificationtf.pkl')

    text_features1 = tfidf.transform(x)

    output1 = k.predict(text_features1)
    # return output1

    # df_output = pd.DataFrame(data=output1, columns=['category_factor'])

    catlable = joblib.load('Classificationt_catlabel.pkl')
    # print(catlable)
    sq = list(map(lambda x: catlable[x], output1))
    # df = output1.apply(lambda x: catlable[x])
    return output1[0]
    # print(df['category_factor'])
    # return output1
