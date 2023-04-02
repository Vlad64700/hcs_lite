import express from "express";
//@ts-ignore
import cors from "cors";
import path from 'path';
import fileUpload from 'express-fileupload'


import { usersRouter } from "./Routes/usersRouter";
import { sensorsCountersRouter } from "./Routes/sensorsCountersRouters";
import { meterValueRouter } from "./Routes/meterValueRouters";
import { authRouter } from "./Routes/authRouters";
const app = express();

app.use(cors());
//автопарсинг json'ов
app.use(express.json());
//для приема файлов
app.use(fileUpload({
    createParentPath: true
}));

//конфигурация контроллеров и роутов которым они отвечают
app.use("/api/users", usersRouter);
app.use("/api/sensors", sensorsCountersRouter);
app.use("/api/values", meterValueRouter);
app.use("/auth", authRouter);


export default app;