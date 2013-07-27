exports.twitter = (config)->
	OAuth = require("OAuth").OAuth
	byline = require("byline")

	oa = new OAuth 'http://twitter.com/oauth/request_token',
		'http://twitter.com/oauth/access_token',
		config.key.consumer_key,
		config.key.consumer_secret,
		'1.0A', null, 'HMAC-SHA1'

	req = oa.get 'https://userstream.twitter.com/1.1/user.json',
			config.key.access_token,
			config.key.access_token_secret

	req.on 'response', (res) ->
		res.setEncoding('utf8')
		ls = byline.createLineStream(res)

		ls.on 'data', (line) ->
			if(line isnt '')
				data = JSON.parse line
				# console.log data
				console.log 'get'
			else
				console.log "isnt"
			return
		ls.on 'end', () ->
			console.log '----END----'
			return
		return
	req.end()
	return
