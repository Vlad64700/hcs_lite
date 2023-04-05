import { Request, Response } from "express";

import { pool as db } from "../db";
import { generateAccessToken } from "../auth/generateAccessToken";
import { apidb } from "../api/db";

import { SHA_1 } from "../sha1"

// route: /auth
export class AuthController {
  async registration(req: Request, res: Response) {
    try {
      //пароль приходит уже зашифрованный
      let { name, login, password, email } = req.body;
      const foundUser = await db.query("SELECT * FROM users WHERE login = $1", [
        login,
      ]);

      if (foundUser.rowCount > 0) {
        return res.status(400).json({ message: "The user already exists" });
      }
      password=SHA_1(password).out_SHA_1;
      //@ts-ignore
      const newUser = await apidb.createUser(
        name,
        "prending",
        login,
        password,
        email
      );
      return res.json({name: newUser.name});
    } catch (e) {
      console.log(e);
      return res.status(400).json({ message: e });
    }
  }

  async login(req: Request, res: Response) {
    try {
      //пароль приходит уже зашифрованный
      let { login, password } = req.body;
      password=SHA_1(password).out_SHA_1;

      const user = await db.query("SELECT * FROM users WHERE login = $1", [
        login,
      ]);

      if (!user.rowCount) {
        return res.status(400).json({ message: "User not found." });
      }

      //сверяем пароли
      const isValidPassword = password === user.rows[0].password;

      if (!isValidPassword) {
        return res.status(400).json({ message: "Incorrect password." });
      }

      const token = generateAccessToken({ ...user.rows[0] });
      return res.json({
        token,
        id: user.rows[0].user_id,
        name: user.rows[0].name,
        login: user.rows[0].login,
        role: user.rows[0].role,
        email: user.rows[0].email,
      });
    } catch (error) {
      console.log(error);
      const message = "Login error";
      return res.status(400).json({ message: message });
    }
  }
}
