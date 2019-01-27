const settings = require('./settings.json');
const express = require('express');

const Eth = require('ethjs');
const EthereumTx = require('ethereumjs-tx');
const Abi = require('ethjs-abi');

var app = express();
app.use(express.json());

app.get('/home', (req, res) => {
    res.send({
        plaintext: result,
        timestamp: Date.now()
    });
});