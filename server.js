// Express
const express = require('express');
const engines = require('consolidate');
const shortener = require('./functions/shortener');
const path = require('path');
const app = express();

const SERVERURL = process.env.SERVER_URL || 'localhost';
const SERVERPORT = process.env.SERVER_PORT || 3000;
const EXTPORT = process.env.SERVER_EXT || 3000;


const REDISURL = process.env.REDIS_URL || 'localhost';
const REDISPORT = process.env.REDIS_PORT || 6379;


app.use(express.static(path.join(__dirname, 'static')));
app.set('views', __dirname + '/static');
app.engine('html', engines.mustache);
app.set('view engine', 'html');


// Database
let redis = require('redis');
let client = redis.createClient(REDISPORT, REDISURL); // this creates a new client

client.on('connect', function () {
    console.log('Redis client connected on ' + REDISURL + ':' + REDISPORT);
});

client.on('error', function (err) {
    console.log('Something went wrong [' + REDISURL + ':' + REDISPORT + '] ' + err);
});


// Homepage
app.get('/', (req, res) => {
    res.render("static/index.html");
});


// Shortener
app.get('/shorten', (req, res) => {

    let url = req.query.url;
    let key = req.query.key;

    if (key === "") {
        key = Math.random().toString(36).substr(2, 5);
    }

    client.exists('key', function (err, reply) {

        if (reply === 1) {

        } else {
            client.set(key, url, redis.print);
            console.log('shortened ' + url + ' with ' + key);
        }

    });

    res.json({
        'href': 'http://' + SERVERURL + ':' + SERVERPORT + '/' + key,
        'display': 'http://' + SERVERURL + '/' + key
    });

});


// Redirect
app.get('/:key', (req, res) => {
    client.get(req.params.key, function (error, response) {


        if (error || response === null) {

            console.log(error);
            res.render('404', {url: req.url});

        } else {

            res.redirect(response.toString());
        }
    });
});

// Listener
console.log();
console.log();
console.log('      ::::::::: ::::::::::: :::::::::: ::::    ::: ::::::::::: ');
console.log('     :+:    :+:    :+:     :+:        :+:+:   :+:     :+:      ');
console.log('    +:+    +:+    +:+     +:+        :+:+:+  +:+     +:+       ');
console.log('   +#++:++#+     +#+     +#++:++#   +#+ +:+ +#+     +#+        ');
console.log('  +#+           +#+     +#+        +#+  +#+#+#     +#+         ');
console.log(' #+#           #+#     #+#        #+#   #+#+#     #+#          ');
console.log('###       ########### ########## ###    #### ###########       ');
console.log();
console.log('===============================================================');
console.log();
console.log('An URLShortener with a small footprint, with node.js and redis.');
console.log();
console.log('===============================================================');
console.log();


app.listen(SERVERPORT, () => console.log(`server started on http://${SERVERURL}:${EXTPORT}`));