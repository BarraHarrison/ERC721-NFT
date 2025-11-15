const express = require("express");
const path = require("path");

const app = express();
const PORT = 3000;

app.use("/metadata", express.static(path.join(__dirname, "..", "metadata")));

app.listen(PORT, () => {
    console.log(`🚀 Local metadata server running at: http://localhost:${PORT}/metadata/1.json`);
});
