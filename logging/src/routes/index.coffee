
#
# * GET home page.
#
exports.index = (req, res) ->
	config = module.parent.exports.set("config")
	res.render "index",
			title: "Express"

