import { Request, Response } from "express";
import { pool as db } from "../db";
import { apidb } from "../api/db";

// route: /api/sensors/
export class SensorsCountersController {
  //добавить get запрос по object_id

  async getSensors(req: Request, res: Response) {
    try {
      const sensors = await apidb.getSensors();
      return res.json(sensors);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);

      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async getSensorByMeterId(req: Request, res: Response) {
    try {
      const id = req.params.meter_id;
      if (isNaN(+id)) {
        throw new Error("некорректный айди сенсора");
      }
      const sensor = await apidb.getSensorByMeterId(+id);

      return res.json(sensor);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async getSensorsByUserId(req: Request, res: Response) {
    try {
      const id = req.params.user_id;

      if (isNaN(+id)) {
        throw new Error("некорректный айди пользователя");
      }
      const sensor = await apidb.getSensorsByUserId(+id);
      return res.json(sensor);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async createSensor(req: Request, res: Response) {
    //можно ли тут предотвратить добавление в бд одинаковых данных? нужно ли7
    try {
      const { user_id, description, meter_name } = req.body;

      if (isNaN(+user_id)) {
        throw new Error("некорректный айди пользователя");
      }

      if (description.indexOf(';')!==-1 || description.indexOf('(')!==-1 || description.indexOf(')')!==-1 ) {
        throw new Error("некорректное описание");
      }

      if (meter_name.indexOf(';')!==-1 || meter_name.indexOf('(')!==-1 || meter_name.indexOf(')')!==-1 ) {
        throw new Error("некорректное описание");
      }
      const newSensor = await apidb.createSensor(
        user_id,
        description,
        meter_name
      );
      return res.json(newSensor);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async updateSensor(req: Request, res: Response) {
    try {
      const { meter_id, user_id, description, meter_name } = req.body;

      if (isNaN(+meter_id)) {
        throw new Error("некорректный айди сенсора");
      }

      if (isNaN(+user_id)) {
        throw new Error("некорректный айди пользователя");
      }

      if (description.indexOf(';')!==-1 || description.indexOf('(')!==-1 || description.indexOf(')')!==-1 ) {
        throw new Error("некорректное описание");
      }

      if (meter_name.indexOf(';')!==-1 || meter_name.indexOf('(')!==-1 || meter_name.indexOf(')')!==-1 ) {
        throw new Error("некорректное описание");
      }
      const sensor = await apidb.updateSensor(
        meter_id,
        user_id,
        description,
        meter_name
      );
      return res.json(sensor);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async deleteSensor(req: Request, res: Response) {
    try {
      const id = req.params.meter_id;

      if (isNaN(+id)) {
        throw new Error("некорректный айди сенсора");
      }
      const sensor = await apidb.deleteSensor(+id);
      return res.json(sensor);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }
}
