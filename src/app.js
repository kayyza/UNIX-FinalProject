const express = require ('express');
const app = expresss();
const PORT = 8000;

app.get('/', (req, res) => {
    res.send("The website is working!");
});

app.listen(PORT, function () {
    console.log(`listening on port ${PORT}`);
});

