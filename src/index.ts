import dotenv from "dotenv";
import app from "./app";

const http = require('http');


//загружаем переменные из файла .env
dotenv.config();

const PORT = process.env.PORT || 80;
const httpServer = http.createServer(app);

httpServer.listen(PORT, () => {
    console.log(`HTTP Server running on port ${PORT}`);
});

