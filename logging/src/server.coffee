###
logging twitter Project
###

express = require("express")
http = require("http")
app = module.exports = express()
path = require("path")
config = JSON.parse(require("fs").readFileSync(
							__dirname + "/../config.json"))

# all environments
app.configure ->
	app.set "port", process.env.PORT or 3000
	app.set "views", __dirname + "/../views"
	app.set "view engine", "jade"
	app.use express.favicon()
	app.use express.logger("dev")
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use express.static(path.join(__dirname, "public"))
	app.set "config", config
	return



# development only
app.use express.errorHandler()  if "development" is app.get("env")

routes = []
fs = require("fs")
files = fs.readdirSync(__dirname + "/routes")

for i of files
	ext = files[i].substr(files[i].lastIndexOf("."), files[i].length)
	name = files[i].substr(0, files[i].lastIndexOf("."))
	if ext is ".js"
		routes[name] = require("./routes/"  + name)
		for j of routes[name]
			eval "var myfunc = routes[name]." + j
			if j.substr(0,4) is "get_"
				method = j.substr(4, j.length)
				app.get "/" + method, myfunc
			else if j.substr(0, 5) is "get_"
				method = j.substr(5, j.length)
				app.post "/" + method, myfunc
			else
				app.get "/" + j, myfunc
app.get "/", routes["index"].index

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
