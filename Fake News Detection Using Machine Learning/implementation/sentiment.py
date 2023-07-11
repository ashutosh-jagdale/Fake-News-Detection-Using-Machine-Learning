#!pip install vaderSentiment
#!pip install -U textblob
from textblob import TextBlob
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

title = 'PIN DROP SPEECH BY FATHER OF DAUGHTER Kidnapped And Killed By ISIS: "I have voted for Donald J. Trump!" Â¬Âª 100percentfedUp.com'

def sentiment(title):
    analyser = SentimentIntensityAnalyzer()
    snt = analyser.polarity_scores(title)
    opinion = TextBlob(title)
    polarity = opinion.sentiment.polarity
    if snt['pos'] == 0 and snt['neg'] == 0:
      sentiment_score = 0
    else:
      if snt['pos'] == 0:
        sentiment_score = (((polarity*-1) +  snt['neg'])/2)*(-1.0)
      else:
        sentiment_score = (snt['pos'] +  polarity)/2
    return sentiment_score

print(sentiment(title))