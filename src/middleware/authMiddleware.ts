import { Request, Response } from "express";
import jwt from "jsonwebtoken";

import { secret } from "../config";

interface IUser {
user_id: string,
name : string,
login: string,
role: string,
email: string
}



//middleware проверяющий авторизован ли пользователь
export const authMiddleware = (
  req: Request,
  res: Response,
  next: () => void
) => {
  try {
    console.log(req.method);
    //т.к. токен имеет вид: "Bearer f$dksljgtFDJKSFHajgdgkjd",
    //то берем часть строки после пробела
    const token = req.headers.authorization?.split(" ")[1];
    if (!token) {
      return res.redirect("https://smarthcs.ru/login");
    }
    const decodedData = jwt.verify(token, secret.key);
    //@ts-ignore
    req.user = decodedData.user_id;
    next();
  } catch (error) {
    console.log(error);
    return res.redirect("https://smarthcs.ru/login");
  }
};
