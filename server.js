// Express
const express = require('express');
const engines = require('consolidate');
const shortener = require('./functions/shortener');
const bodyParser = require('body-parser');
const morgan = require('morgan');
const path = require('path');
const app = express();

// Consts are set from environment if not set, the default values are used
const SERVERURL = process.env.SERVER_URL || 'localhost';
const SERVERPORT = process.env.SERVER_PORT || 3000;
const EXTPORT = process.env.SERVER_EXT || 3000;
const REDISURL = process.env.REDIS_URL || 'localhost';
const REDISPORT = process.env.REDIS_PORT || 32769;

// Configure the service
app.use(express.static(path.join(__dirname, 'static')));
app.use(morgan('combined'));
app.set('views', __dirname + '/static');
app.engine('html', engines.mustache);
app.set('view engine', 'html');
app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
    extended: true
}));


// Datastore
// Create a new redis Client
let redis = require('redis');
let client = redis.createClient(REDISPORT, REDISURL);


client.on('connect', function () {
    console.log('Redis client connected to Redis Server on [' + REDISURL + ':' + REDISPORT + ']');
});

client.on('error', function (err) {
    console.log('Something went wrong [' + REDISURL + ':' + REDISPORT + '] ' + err);
});


// Homepage
app.get('/', (req, res) => {
    res.render("static/index.html");
});

// Liveness and Health Probes
app.get('/liveness', (req, res) => {
    res.json({
        "app": {
            "version": "1.0.0",
            "name": "Pieni",
            "description": "An URL Shortener with a small footprint, written with node.js and redis."
        }
    });
});

app.get('/health', (req, res) => {
    res.json({"status": "UP"});
});


// Shortener as GET
app.get('/shorten', (req, res) => {

    let url = req.query.url;
    let key = req.query.key;

    key = shortener.generateKey(key);

    client.set(key, url, redis.print);
    console.log('shortened ' + url + ' with ' + key);

    res.json({
        'href': 'http://' + SERVERURL + '/' + key,
        'display': 'http://' + SERVERURL + '/' + key
    });

});

// Shortener as POST
app.post('/shorten', (req, res) => {

    let url = req.body.url;
    let key = req.body.key;

    if (key === "" || key === undefined || key === null) {
        key = Math.random().toString(36).substr(2, 5);
    }

    client.set(key, url, redis.print);
    console.log('shortened ' + url + ' with ' + key);

    res.json({
        'href': 'http://' + SERVERURL + '/' + key,
        'display': 'http://' + SERVERURL + '/' + key
    });

});



// Redirect
app.get('/:key', (req, res) => {
    client.get(req.params.key, function (error, response) {

        if (error || response === null) {
            console.log(error);
            console.log('could not find ' + key + ' sending user to 404');
            res.render('404', {url: req.url});
        } else {
            res.redirect(response.toString());
            console.log('redirect ' + req.params.key + ' to ' + response.toString());
        }
    });
});


// print the application Head
shortener.printHead();

// Listener
app.listen(SERVERPORT, () => console.log(`server started on http://${SERVERURL}:${EXTPORT}`));