
# load packages
require(twitter)
require(stringr)
require(wordcloud)

CUSTOMER_KEY="CEuKPXF2IyvpRaulflDu1NWOj"
CUSTOMER_SECRET="OAtICxTVZvosXDrAF0AEX2cq5vIONKgPqCu3zoiBoV0RDy1MdR"
ACCESS_TOKEN="535954553-47raNRkALvzBi8cOjxh5fzmNVrfJJMOPmL0CZG4B"
ACCESS_secret="yJnNHt8iEVljp4Ay9BPlL36ITmqdGhWGrAcT0NHJ8wfB8"

setup_twitter_oauth(CUSTOMER_KEY, CUSTOMER_SECRET, ACCESS_TOKEN, ACCESS_secret)
# harvest tweets from each user account
realDonaldTrump_tweets = userTimeline("realDonaldTrump", n=2500)
hillaryclinton_tweets = userTimeline("hillaryclinton", n=2500)

# dump tweets information into data frames
realDonaldTrump_df = twListToDF(realDonaldTrump_tweets)
hillaryclinton_df = twListToDF(hillaryclinton_tweets)

# get the hashtags
realDonaldTrump_hashtags = str_extract_all(realDonaldTrump_df$text, "#\\w+")
hillaryclinton_hashtags = str_extract_all(hillaryclinton_df$text, "#\\w+")

# put tags in vector
realDonaldTrump_hashtags = unlist(realDonaldTrump_hashtags)
hillaryclinton_hashtags = unlist(hillaryclinton_hashtags)

# calculate hashtag frequencies
realDonaldTrump_tags_freq = table(realDonaldTrump_hashtags)
hillaryclinton_tags_freq = table(hillaryclinton_hashtags)


# realDonaldTrump hashtags wordcloud
wordcloud(names(realDonaldTrump_tags_freq), realDonaldTrump_tags_freq, random.order=FALSE, 
          colors="#1B9E77")
title("\n\nHashtags in tweets from @realDonaldTrump",
      cex.main=1.5, col.main="gray50")

# hillaryclinton hashtags wordcloud
wordcloud(names(hillaryclinton_tags_freq), hillaryclinton_tags_freq, random.order=FALSE, 
          colors="#7570B3")
title("\nHashtags in tweets from @hillaryclinton",
      cex.main=1.5, col.main="gray50")


# Now let's plot one single wordcloud
# vector of colors
cols = c(
  rep("#DD2F2F", length(realDonaldTrump_tags_freq)),
  rep("#4092F5", length(hillaryclinton_tags_freq))
)

# put all tags in a single vector
all_tags = c(realDonaldTrump_tags_freq, hillaryclinton_tags_freq)

# wordcloud
wordcloud(names(all_tags), all_tags, random.order=TRUE, min.freq=1, 
          colors=cols, ordered.colors=TRUE)
mtext(c("@realDonaldTrump", "@hillaryclinton"), side=2,
      line=2, at=c(0.25, 0.5, 0.75), col=c("#DD2F2F", "#4092F5"),
      family="serif", font=2, cex=1.5)
