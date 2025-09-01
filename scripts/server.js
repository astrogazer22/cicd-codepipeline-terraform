const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Node.js on EC2 with CI/CD!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
