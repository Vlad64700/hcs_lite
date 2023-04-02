import { Request, Response } from "express";

import { pool as db } from "../db";
import { generateAccessToken } from "../auth/generateAccessToken";
import { apidb } from "../api/db";

// route: /auth
export class AuthController {
  async registration(req: Request, res: Response) {
    try {
      //пароль приходит уже зашифрованный
      const { name, login, password, email } = req.body;
      const foundUser = await db.query("SELECT * FROM users WHERE login = $1", [
        login,
      ]);

      if (foundUser.rowCount > 0) {
        return res.status(400).json({ message: "The user already exists" });
      }
      //@ts-ignore
      const newUser = await apidb.createUser(
        name,
        "user",
        login,
        password,
        email
      );
      return res.json(newUser);
    } catch (e) {
      console.log(e);
      const message = "Registration error";
      return res.status(400).json({ message: message });
    }
  }

  async login(req: Request, res: Response) {
    try {
      //пароль приходит уже зашифрованный
      const { login, password } = req.body;
      console.log(password);

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
