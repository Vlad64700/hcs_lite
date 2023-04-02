import { Request, Response } from "express";
import { pool as db } from "../db";
import { apidb } from "../api/db";
import { REPLServer } from "repl";
const fs = require("fs");
const path = require("path");

// route: /api/users/
export class UsersController {
  async getUsers(req: Request, res: Response) {
    try {
      const users = await apidb.getUsers();
      return res.json(users);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async getOneUser(req: Request, res: Response) {
    try {
      const id = req.params.id;
      if (isNaN(+id)) {
        throw new Error("incorrect params");
      }
      const user = await apidb.getUserByUserId(+id);
      return res.json(user);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async getPendingUsers(req: Request, res: Response) {
    try {
      const user = await apidb.getPendingUsers();
      return res.json(user);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async getUserRoles(req: Request, res: Response) {
    try {
      const user = await apidb.getUserRoles();
      return res.json(user);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async createUser(req: Request, res: Response) {
    try {
      const { name, role, login, password, email } = req.body;

      if (name.length>255) {
        throw new Error("имя слишком длинное");
      }

      if (email.length>55) {
        throw new Error("почта слишком длинная");
      }

      if (name.indexOf('(')!==-1 || name.indexOf(')')!==-1 || name.indexOf('.')!==-1 || name.indexOf(',')!==-1 || name.indexOf(';')!==-1) {
        throw new Error("для имени используются недопустимые символы");
      }

      if (login.indexOf('(')!==-1 || login.indexOf(')')!==-1 || login.indexOf('.')!==-1 || login.indexOf(',')!==-1 || login.indexOf(' ')!==-1 || login.indexOf(';')!==-1) {
        throw new Error("для логина используются недопустимые символы");
      }

      if (email.indexOf(';')!==-1) {
        throw new Error("для логина используются недопустимые символы");
      }
      const newUser = await apidb.createUser(
        name,
        "pending",
        login,
        password,
        email
      );
      return res.json(newUser);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async updateUser(req: Request, res: Response) {
    try {
      const { user_id, name, role, login, password, email } = req.body;

      if (isNaN(user_id)) {
        throw new Error("некорректный айди пользователя");
      }
      if (name.length>255) {
        throw new Error("имя слишком длинное");
      }

      if (email.length>55) {
        throw new Error("почта слишком длинная");
      }

      if (name.indexOf('(')!==-1 || name.indexOf(')')!==-1 || name.indexOf('.')!==-1 || name.indexOf(',')!==-1 || name.indexOf(';')!==-1) {
        throw new Error("для имени используются недопустимые символы");
      }

      if (login.indexOf('(')!==-1 || login.indexOf(')')!==-1 || login.indexOf('.')!==-1 || login.indexOf(',')!==-1 || login.indexOf(' ')!==-1 || login.indexOf(';')!==-1) {
        throw new Error("для логина используются недопустимые символы");
      }

      if (email.indexOf(';')!==-1) {
        throw new Error("для логина используются недопустимые символы");
      }

      const user = await apidb.updateUser(
        user_id,
        name,
        role,
        login,
        password,
        email
      );
      return res.json(user);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async updateUserProfile(req: Request, res: Response) {
    try {
      const { user_id, name, login, email } = req.body;

      if (isNaN(user_id)) {
        throw new Error("некорректный айди пользователя");
      }
      if (name.length>255) {
        throw new Error("имя слишком длинное");
      }

      if (email.length>55) {
        throw new Error("почта слишком длинная");
      }

      if (name.indexOf('(')!==-1 || name.indexOf(')')!==-1 || name.indexOf('.')!==-1 || name.indexOf(',')!==-1 || name.indexOf(';')!==-1) {
        throw new Error("для имени используются недопустимые символы");
      }

      if (login.indexOf('(')!==-1 || login.indexOf(')')!==-1 || login.indexOf('.')!==-1 || login.indexOf(',')!==-1 || login.indexOf(' ')!==-1 || login.indexOf(';')!==-1) {
        throw new Error("для логина используются недопустимые символы");
      }

      if (email.indexOf(';')!==-1) {
        throw new Error("для логина используются недопустимые символы");
      }
      const user = await apidb.updateUserProfile(user_id, name, login, email);
      return res.json(user);
    } catch (e) {
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async updateUserPassword(req: Request, res: Response) {
    try {
      const { user_id, old_password, new_password } = req.body;

      if (isNaN(user_id)) {
        throw new Error("некорректный айди пользователя");
      }
      const user = await apidb.updateUserPassword(
        user_id,
        old_password,
        new_password
      );
      return res.json(user);
    } catch (e) {
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async updateUserRole(req: Request, res: Response) {
    try {
      const { user_id, role } = req.body;

      if (isNaN(user_id)) {
        throw new Error("некорректный айди пользователя");
      }

      if (role.indexOf(' ')!==-1 || role.length>10) {
        throw new Error("некорректный айди пользователя");
      }
      const user = await apidb.updateUserRole(user_id, role);
      return res.json(user);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async deleteUser(req: Request, res: Response) {
    try {
      
      const id = req.params.id;

      if (isNaN(+id)) {
        throw new Error("некорректный айди пользователя");
      }
      const user = await apidb.deleteUser(+id);
      return res.json(user);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }
}
