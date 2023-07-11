from flask import Flask, request, jsonify
import json
from toxicity import *
from spam import *
from classification import *
from sentiment import *
from stance import *
from Final_model import final_model
from clickbait import *
from PoliticalAff import *
from domin import *
app = Flask(__name__)


@app.route("/", methods=['POST'])
def hello():
    data = json.loads(request.data)
    title = data['title']
    text = data['text']
    news = data['title'] + data['text']
    url = data['url']
    #print(url)
    
    #Toxicity
    a = toxicity(news)
    
    #Spam
    input=[news]
    b = spam(input)
    
    #Classification
    c = classification(input)
    catlable = joblib.load('Classificationt_catlabel.pkl')
    sq = list(map(lambda x: catlable[x], [c]))
    print(c)
    
    #Sentiment
    d = sentiment(news) # direct num
    
    #Stance
    df_temp = {'title': [title], 'text': [text]}
    df = pd.DataFrame.from_dict(df_temp)
    e = stance(df)
    #print(e)
    
    #Political Affiliation
    dict_aff = {'site_url': url,'src_url_polarity':[0]}
    df_aff = pd.DataFrame.from_dict(dict_aff)
    h = Affi(df_aff)
    h = float(h)
    
    #ClickBait
    i = clickbait(title)
    
    #Domain Rank
    rank = domain_rankk(url)
    
    #Final Model
    final_df = {'title': [title],'text':[text],'spam_score_fector':[b],'click_bait_score' : [0], 'category_factor_num' : [c], 'toxicity_factor' : [a], 'src_url_polarity':[0],'sentiment_score' : [d],'stance':[e], 'stance_factor_num' : [0], 'domain_rank':[rank]}
    final_df1 = pd.DataFrame.from_dict(final_df)
    f = final_model(final_df1)
    
    
    
    if f >= 90: rr = ('True')
    elif f < 90 and f >= 75: rr = ('Mostly True')
    elif f < 75 and f >= 50: rr = ('Half True')
    elif f < 50 and f >= 40: rr =('Mostly False')
    elif f < 40 and f >= 25: rr = ('False')
    else: rr = ('Pants On Fire')
    # X = df[[ 'spam_score_fector','click_bait_score',
    # 'category_factor_num', 'toxicity_factor',
    # 'src_url_polarity','sentiment_score',
    # 'stance_factor_num']]
 
    #type(b)
    print("+++++++++++++++++++++++++++++++"+str(int(f)))
    return jsonify({"final": str(int(f)), "result":rr, "spam" : str(round(b, 3)), "category" : sq[0], "toxicity": str(round(a, 3)), "sentiment":str(round(d, 3)), "stance":e, "clickbait" : str(round(i,3)), "political":str(h), "domain":str(rank)})


if __name__ == '__main__':
    def text_process(mess):
        nopunc = [char for char in mess if char not in string.punctuation]
        nopunc = ''.join(nopunc)
        return [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]
    app.run(debug=True)

#Muslims BUSTED: They Stole Millions In Govâ€šÃ„Ã´t Benefits  
#Print They should pay all the back all the money plus interest. The entire family and everyone who came in with them need to be deported asap. Why did it take two years to bust them Here we go again â€šÃ„Â¶another group stealing from the government and taxpayers! A group of Somalis stole over four million in government benefits over just 10 months Weâ€šÃ„Ã´ve reported on numerous cases like this one where the Muslim refugees/immigrants commit fraud by scamming our systemâ€šÃ„Â¶Itâ€šÃ„Ã´s way out of control! More Related