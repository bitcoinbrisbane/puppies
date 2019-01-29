const settings = require('./settings.json');
const express = require('express');
const hbs = require('hbs');

// const Eth = require('ethjs');
// const EthereumTx = require('ethereumjs-tx');
// const Abi = require('ethjs-abi');

var app = express();
//app.use(express.json());

app.set('view engine', 'hbs');
app.use(express.static(__dirname + '/public'))

app.get('/home', (req, res) => {
    res.send({
        plaintext: result,
        timestamp: Date.now()
    });
});

app.get('/index', (req, res) => {
    res.render('index.hbs')
});

app.listen(3001);