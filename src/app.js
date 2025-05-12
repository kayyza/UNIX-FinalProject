const express = require ('express');
const app = express();
const PORT = 9000;

app.get('/', (req, res) => {
    res.send("The website is working!");
});

app.listen(PORT, function () {
    console.log(`listening on port ${PORT}`);
});

