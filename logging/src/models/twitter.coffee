Oauth = require("oauth").Oauth
byline = require("byline")

oa = new Oauth('http://twitter.com/oauth/request_token',
  'http://twitter.com/oauth/access_token',
  config.consumer_key,
  config.consumer_secret,
  '1.0A', null, 'HMAC-SHA1')

endpoint = 'https://userstream.twitter.com/1.1/user.json'

