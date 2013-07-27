
#
# * GET home page.
#
exports.index = (req, res) ->
	config = module.parent.exports.set("config")
	res.render "index",
			title: "Express"

exports.run = (req,res) ->
	config = module.parent.exports.set("config")
	twitter = require '../models/twitter'
	twitter.twitter(config)
	res.render 'index', title: 'UserStream'