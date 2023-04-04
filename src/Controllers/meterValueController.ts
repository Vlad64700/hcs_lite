import { Request, Response } from "express";
import { collapseTextChangeRangesAcrossMultipleVersions } from "typescript";
import { apidb } from "../api/db";

// route: /api/values/
export class MeterValueController {
  constructor() {}
  async getValues(req: Request, res: Response) {
    try {
      const values = await apidb.getMeterValue();
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  getPeriod(
    year: number,
    month: number,
    day: number,
    hours: number,
    minutes: number
  ): string {
    if (month >= 12 || day > 31 || hours > 24 || minutes > 60) {
      throw new Error("incorrect params (get period)");
    }
    const date: Date = new Date();
    year = year ? date.getFullYear() - year : date.getFullYear();
    month = month ? date.getMonth() - month : date.getMonth();
    day = day ? date.getDate() - day : date.getDate();
    hours = hours ? date.getHours() - hours : date.getHours();
    minutes = minutes ? date.getMinutes() - minutes : date.getMinutes();

    return new Date(year, month, day, hours, minutes).getTime().toString();
  }

  getValuesByMeterId = async (req: Request, res: Response) => {
    //прилетает кол-во лет, месяцев, дней, часов минут за которые надо вернуть показания
    const { meter_id, count, years, months, days, hours, minutes } = req.body;
    if (isNaN(meter_id) || isNaN(count)) {
      throw new Error("incorrect params");
    }
    try {
      let time: string;
      if (!years && !months && !days && !hours && !minutes) {
        time = this.getPeriod(1, months, days, hours, minutes);
      } else {
        time = this.getPeriod(years, months, days, hours, minutes);
      }
      //@ts-ignore
      const values = await apidb.getMeterValueByMeterId(meter_id, time, count);
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  };

  //вернет срдение показания за года
  getValuesByMeterIdAvgYear = async (req: Request, res: Response) => {
    //прилетает кол-во лет, месяцев, дней, часов минут за которые надо вернуть показания
    const { meter_id, year_start, year_end } = req.body;
    if (isNaN(meter_id) || isNaN(year_start) || isNaN(year_end)) {
      throw new Error("incorrect params");
    }
    try {
      const values = await apidb.getMeterValueByMeterId_AvgYear(
        meter_id,
        year_start,
        year_end
      );
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  };

  //вернет срдение показания за месяца
  getValuesByMeterIdAvgMonth = async (req: Request, res: Response) => {
    //прилетают года в которых надо усреднить показания ПО МЕСЯЦАМ
    const { meter_id, year_start, year_end } = req.body;
    if (isNaN(meter_id) || isNaN(year_start) || isNaN(year_end)) {
      throw new Error("incorrect params");
    }
    try {
      const values = await apidb.getMeterValueByMeterId_AvgMonth(
        meter_id,
        year_start,
        year_end
      );
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  };

  //вернет срдение показания за дни в течение месяца
  getValuesByMeterIdAvgWeek = async (req: Request, res: Response) => {
    //прилетает месяц и год в котором надо усреднить показания ПО НЕДЕЛЯМ
    const { meter_id, year, month } = req.body;
    if (isNaN(meter_id) || isNaN(year) || isNaN(month)) {
      throw new Error("incorrect params");
    }
    try {
      const values = await apidb.getMeterValueByMeterId_AvgWeek(
        meter_id,
        year,
        month
      );
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  };

  //вернет срдение показания за дни в течение месяца
  getValuesByMeterIdAvgDay = async (req: Request, res: Response) => {
    //прилетает месяц и год в котором надо усреднить показания ПО ДНЯМ
    const { meter_id, year, month } = req.body;

    if (isNaN(meter_id) || isNaN(year) || isNaN(month)) {
      throw new Error("incorrect params");
    }
    try {
      const values = await apidb.getMeterValueByMeterId_AvgDay(
        meter_id,
        year,
        month
      );
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  };

  async getValuesByUserId(req: Request, res: Response) {
    try {
      const user_id = req.params.user_id;
      if (isNaN(+user_id)) {
        throw new Error("incorrect params");
      }

      const values = await apidb.getMeterValueByUserId(+user_id);
      return res.json(values);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async createMeterValue(req: Request, res: Response) {
    try {
      const { meter_id, value } = req.body;

      if (isNaN(meter_id) || isNaN(value)) {
        throw new Error("incorrect params");
      }
      const newValue = await apidb.createMeterValue(meter_id, null, value);

      throw new Error("there is no sub-tariff for this period");
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }

  async deleteMeterValue(req: Request, res: Response) {
    try {
      const id = req.params.measurement_id;

      if (isNaN(+id)) {
        throw new Error("incorrect params");
      }

      const value = await apidb.deleteMeterValue(+id);
      return res.json(value);
    } catch (e) {
      console.log(`\nОшибка доступа к БД \n${e} \n`);
      return res
        .status(400)
        .json({ message: `Database request error \n ${e}` });
    }
  }
}
