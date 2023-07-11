
def Affi(dct):
    dct['src_url_polarity']= 0.5
    dct.loc[dct.site_url.str.contains('consortiumnews|usatoday|politifact|sctimes|timesofsandiego'),'src_url_polarity'] = '0.5'
    dct.loc[dct.site_url.str.contains('presstv|mintpressnews|latimes|chicagotribune|bustle|natmonitor|politico'),'src_url_polarity'] = '0.4'
    dct.loc[dct.site_url.str.contains('antiwar|russia-insider|sputniknews|strategic-culture|postbulletin|hpenews|ustfactsdaily'),'src_url_polarity'] = '0.6'
    dct.loc[dct.site_url.str.contains('politicususa|opednews|liberalamerica|truthdig|counterpunch|blackagendareport|guardianlv|ahtribune|intrepidreport|wakingtimes|addictinginfo|activistpost|other98|countercurrents|huffingtonpost|rabble|cnn'),'src_url_polarity'] = '0.2'
    dct.loc[dct.site_url.str.contains('naturalnews|ijr|wearechange|awdnews|twitchy|thenewamerican|amtvmedia|abovetopsecret|nowtheendbegins|thecommonsenseshow|fromthetrenchesworldreport|nakedcapitalism|prisonplanet|investmentwatchblog|ronpaulinst|thecontroversialfiles|gulagbound|rt|thedailybell|corbettreport|zerohedge|whatreally|wikileaks|newstarg|regated|southfront'),'src_url_polarity'] = '0.9'
    dct.loc[dct.site_url.str.contains('occupydemocrats|ifyouonlynews|pravdareport|usuncut|newcenturytimes|trueactivist|dailynewsbin'),'src_url_polarity'] = '0.0'
    dct.loc[dct.site_url.str.contains('madworldnews|thefederalistpapers|conservativetribune|libertyunyielding|truthfeed|freedomoutpost|frontpagemag|dccl|othesline|wnd|ihavethetruth|amren|barenakedislam|returnofkings|trunews|jewsnews|shtfplan|lewrockwell|dailystormer|libertynews|endingthefield|dailywire|vdare|100percentfedup|21stcenturywire|westernjournalism|redflagnews|libertywritersnews|conservativedailypost|departed|breitbart|donaldtrumpnews.co|bipartisanreport|americanlookout|spinzon|usapoliticsnow|usanewsflash|hangthebankers|toprightnews|usasupreme|americasfreedomfighters|viralliberty'),'src_url_polarity'] = '1.0'
    
    return dct['src_url_polarity']