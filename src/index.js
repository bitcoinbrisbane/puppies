//const settings = require('./settings.json');
const express = require('express');
const hbs = require('hbs');

// const Eth = require('ethjs');
// const EthereumTx = require('ethereumjs-tx');
// const Abi = require('ethjs-abi');

var app = express();
//app.use(express.json());

app.set('view engine', 'hbs');

app.use(express.static(__dirname + '/css'));
app.use(express.static(__dirname + '/img'));
app.use(express.static(__dirname + '/js'));
app.use(express.static(__dirname + '/public'));
app.use(express.static(__dirname + '/vendor'));

app.get('/home', (req, res) => {
    res.send({
        plaintext: result,
        timestamp: Date.now()
    });
});

app.get('/', (req, res) => {
    res.render('index.hbs', {
        contractAddress: "0xA0bcF49B1Be80CF2eEE60A7BddFbA60fC8A53693"
    });
});

app.listen(3001);