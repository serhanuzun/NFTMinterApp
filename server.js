const express = require('express');
const path = require('path');

const app = express();

// Statik dosyaları sunmak için 'public' klasörünü kullan
app.use(express.static(path.join(__dirname, 'public')));

// Ana sayfayı servis et
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
});
