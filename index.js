// index.js

const express = require('express');
const app = express();
const Web3 = require('web3');

const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Statik dosyaları sunmak için 'public' klasörünü kullanacağız
app.use(express.static(path.join(__dirname, 'public')));

// Ana sayfa için index.html dosyasını kullanacağız
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});