import { Request, Response } from "express";
import jwt from "jsonwebtoken";

import { secret } from "../config";

//middleware проверяющий является ли пользователь админом
export const roleMiddlewareAdmin = (
  req: Request,
  res: Response,
  next: () => void
) => {
  try {
    //т.к. токен имеет вид: "Bearer $dksljgtFDJKSFHajgdgkjd",
    //то берем часть строки после пробела
    const token = req.headers.authorization?.split(" ")[1];
    if (!token) {
      return res.status(403).json({ message: "Not authorized" });
    }

    const decodedData = jwt.verify(token, secret.key);
    if ((decodedData as any).role !== "admin") {
      return res
        .status(403)
        .json({ message: "This operation can only be performed by an admin." });
    }

    next();
  } catch (error) {
    console.log(error);
    return res.status(403).json({ message: "Not authorized" });
  }
};

//middleware проверяющий является ли пользователь админом
export const roleMiddlewareFitter = (
  req: Request,
  res: Response,
  next: () => void
) => {
  try {
    //т.к. токен имеет вид: "Bearer $dksljgtFDJKSFHajgdgkjd",
    //то берем часть строки после пробела
    const token = req.headers.authorization?.split(" ")[1];
    if (!token) {
      return res.status(403).json({ message: "Not authorized" });
    }

    const decodedData = jwt.verify(token, secret.key);
    if ((decodedData as any).role !== "fitter") {
      return res
        .status(403)
        .json({
          message: "This operation can only be performed by an fitter.",
        });
    }

    next();
  } catch (error) {
    console.log(error);
    return res.status(403).json({ message: "Not authorized" });
  }
};
