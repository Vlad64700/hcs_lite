import { constants } from "buffer";
import { Request, Response } from "express";
import { abort } from "process";
import { pool as db } from "../db";

interface IObject {
  object_id: number;
  description: string;
  parent_id: number;
  city: string;
  street: string;
  house: number;
  flat: number;
}

interface IDevice {
  device_id: number;
  device_type_id: number;
  user_id: number;
  object_id: number;
  description: string;
  device_name: string;
  device_tag: string;
  sensors: Array<ISensor>;
}

interface ISensor {
  meter_id?: number;
  object_id: number;
  meter_name: string;
  meter_type: string;
  value_type_id: string;
  value: string;
  time: string;
}

interface ISensorDescription {
  description: string;
  meter_type: string;
  meter_name: string;
}

interface IDeviceDescription {
  device_name: string;
  description: string;
  sensors: Array<ISensorDescription>;
}

interface IValue {
  object: IObject;
  devices: Array<IDevice>;
}

interface IEventsOutOfRange {
  events_out_of_range_id: number;
  range_value_id: number;
  measurement_id: number;
  out_of_range: boolean;
  status: string;
  who_checked: number;
}

class APIDB {
  constructor() {}


  async deleteUser(user_id: number) {
    const findSendor = await db.query(
      "SELECT * FROM users \
      WHERE user_id = $1",
      [user_id]
    );
    if (findSendor.rowCount === 0) {
      throw new Error("Invalid index (user_id)");
    }

  }
  // Table users
  async getUsers() {
    const users = await db.query("SELECT * FROM users");
    return users.rows;
  }

  async getUserByUserId(user_id: number) {
    const user = await db.query("SELECT * FROM users WHERE user_id = $1", [
      user_id,
    ]);
    if (user.rowCount === 0) throw new Error("Invalid index of user");

    return user.rows[0];
  }

  async getUserByLogin(login: string) {
    const user = await db.query("SELECT * FROM users WHERE login = $1", [
      login,
    ]);
    if (user.rowCount === 0) throw new Error("This login does not exist");

    return user.rows[0];
  }
  async getUsersByTelegramId(telegram_id: string) {
    const user = await db.query("SELECT * FROM users WHERE telegram = $1", [
      telegram_id,
    ]);

    return user.rows;
  }

  async getPendingUsers() {
    const findUser = await db.query("SELECT * FROM users WHERE role='pending'");
    return findUser.rows;
  }

  async getUserRoles() {
    const roles = await db.query("SELECT DISTINCT role from users;");
    return roles.rows;
  }

  async createUser(
    name: string,
    role: string,
    login: string,
    password: string,
    email: string,
  ) {
    const findUser = await db.query("SELECT * FROM users WHERE login = $1", [
      login,
    ]);
    if (findUser.rowCount > 0) {
      throw new Error("The user already exists");
    }

    const newUser = await db.query(
      "INSERT INTO users (name, role, login, password, email) \
      VALUES ($1, $2, $3, $4, $5) RETURNING *",
      [name, role, login, password, email]
    );
    return newUser.rows[0];
  }

  async updateUser(
    user_id: number,
    name: string,
    role: string,
    login: string,
    password: string,
    email: string,
  ) {
    const findUser = await db.query("SELECT * FROM users WHERE user_id = $1", [
      user_id,
    ]);
    if (findUser.rowCount === 0) {
      throw new Error("The user doesn't exist");
    }

    const checkLogin = await db.query("SELECT * FROM users WHERE login = $1", [
      login,
    ]);
    if (checkLogin.rowCount > 0 && login !== findUser.rows[0].login) {
      throw new Error("This login already exist!");
    }

    const user = await db.query(
      "UPDATE users SET name = $2, role = $3, \
      login = $4, password = $5, email=$6 WHERE user_id = $1 RETURNING *",
      [user_id, name, role, login, password, email]
    );
    return user.rows[0];
  }

  async updateUserProfile(
    user_id: number,
    name: string,
    login: string,
    email: string,
  ) {
    const findUser = await db.query("SELECT * FROM users WHERE user_id = $1", [
      user_id,
    ]);
    if (findUser.rowCount === 0) {
      throw new Error("The user doesn't exist");
    }

    const checkLogin = await db.query("SELECT * FROM users WHERE login = $1", [
      login,
    ]);
    if (checkLogin.rowCount > 0 && login !== findUser.rows[0].login) {
      throw new Error("This login already exist!");
    }

    const user = await db.query(
      "UPDATE users SET name = $2, login = $3, \
      email=$4 WHERE user_id = $1 RETURNING *",
      [user_id, name, login, email]
    );
    return user.rows[0];
  }


  async updateUserPassword(
    user_id: number,
    old_password: string,
    new_password: string
  ) {
    const findUser = await db.query("SELECT * FROM users WHERE user_id = $1", [
      user_id,
    ]);
    if (findUser.rowCount === 0) {
      throw new Error("The user doesn't exist");
    }

    if (findUser.rows[0].password === old_password) {
      console.log("successful");
      const user = await db.query(
        "UPDATE users SET password=$2 WHERE user_id = $1 RETURNING *",
        [user_id, new_password]
      );
      return user.rows[0];
    }
    throw new Error("Incorrect password");
  }

  async updateUserRole(user_id: number, role: string) {
    const findUser = await db.query("SELECT * FROM users WHERE user_id = $1", [
      user_id,
    ]);
    if (findUser.rowCount === 0) {
      throw new Error("The user doesn't exist");
    }

    const user = await db.query(
      "UPDATE users SET role = $2 \
       WHERE user_id = $1 RETURNING *",
      [user_id, role]
    );
    return user.rows[0];
  }
//

  // Table sensors_counters
  async getSensors() {
    const sensors = await db.query("SELECT * FROM sensors_counters");
    return sensors.rows;
  }

  async getSensorByMeterId(meter_id: number) {
    const sensor = await db.query(
      "SELECT * FROM sensors_counters WHERE meter_id = $1",
      [meter_id]
    );
    if (sensor.rowCount === 0) throw new Error("Invalid index (meter_id)");
    return sensor.rows[0];
  }

  async getSensorsByUserId(user_id: number) {
    const sensor = await db.query(
      "SELECT * from sensors_counters\
       WHERE user_id=$1",
      [user_id]
    );
    if (sensor.rowCount === 0)
      throw new Error("Invalid index (user_id). Not found sensors for user_id");
    return sensor.rows;
  }

  async createSensor(
    user_id: number,
    description: string,
    meter_name: string
  ) {
    const newSensor = await db.query(
      "INSERT INTO sensors_counters (user_id, description, meter_name) \
      VALUES ($1, $2, $3) RETURNING *",
      [
        user_id,
        description,
        meter_name
      ]
    );
    return newSensor.rows[0];
  }

  async updateSensor(
    meter_id: number,
    user_id: number,
    description: string,
    meter_name: string
  ) {
    const findSendor = await db.query(
      "SELECT * FROM sensors_counters \
    WHERE meter_id = $1",
      [meter_id]
    );
    if (findSendor.rowCount === 0) {
      throw new Error("Invalid meter_id");
    }

    const sensor = await db.query(
      "UPDATE sensors_counters SET user_id = $2, description = $3, \
      meter_name = $4 WHERE meter_id = $1 RETURNING *",
      [
        meter_id,
        user_id,
        description,
        meter_name
      ]
    );
    return sensor.rows[0];
  }

  async deleteSensor(meter_id: number) {
    const findSendor = await db.query(
      "SELECT * FROM sensors_counters \
      WHERE meter_id = $1",
      [meter_id]
    );
    if (findSendor.rowCount === 0) {
      throw new Error("Invalid index (meter_id)");
    }

    const sensor = await db.query(
      "DELETE FROM sensors_counters WHERE meter_id = $1 RETURNING *",
      [meter_id]
    );
    return sensor.rows[0];
  }
  //

  //Table mater_value
  async getMeterValue() {
    const values = await db.query("SELECT * FROM meter_values");
    return values.rows;
  }

    //получить средние показатели за месяц
    async getMeterValueByUserId(
      user_id: number
    ) {
      const values = await db.query(
        "SELECT *\
        FROM METER_VALUES C\
        RIGHT JOIN\
          (SELECT B.*,\
              (SELECT A.MEASUREMENT_ID\
                FROM METER_VALUES A\
                WHERE A.METER_ID = B.METER_ID\
                ORDER BY A.TIME DESC\
                LIMIT 1)\
            FROM SENSORS_COUNTERS B\
            WHERE B.USER_ID = $1) D ON C.MEASUREMENT_ID = D.MEASUREMENT_ID",
        [user_id]
      );
  
      return values.rows;
    }
  

  //получить средрние показатели за год
  async getMeterValueByMeterId_AvgYear(
    meter_id: number,
    year_start: number,
    year_end: number
  ) {
    const year_start_timestamp = new Date(Date.UTC(year_start, 0)).getTime();
    const year_end_timestamp = new Date(Date.UTC(year_end, 0)).getTime();

    const values = await db.query(
      "select avg(meter_values.value) y, date_trunc('year', to_timestamp(meter_values.time/1000)::timestamp) as x\
    from meter_values \
    where meter_id=$1 and time>$2 and time <$3\
    group by x\
    order by x",
      [meter_id, year_start_timestamp, year_end_timestamp]
    );
    return values.rows;
  }

  //получить средние показатели за месяц
  async getMeterValueByMeterId_AvgMonth(
    meter_id: number,
    year_start: number,
    year_end: number
  ) {
    const year_start_timestamp = new Date(Date.UTC(year_start, 0)).getTime();
    const year_end_timestamp = new Date(Date.UTC(year_end, 0)).getTime();

    const values = await db.query(
      "select avg(meter_values.value) y, date_trunc('month', to_timestamp(meter_values.time/1000)::timestamp) as x\
    from meter_values \
    where meter_id=$1 and time>$2 and time<$3\
    group by x\
    order by x",
      [meter_id, year_start_timestamp, year_end_timestamp]
    );

    return values.rows;
  }

  //получить средние показатели за день - за конкретный год и конкретный месяц
  async getMeterValueByMeterId_AvgDay(
    meter_id: number,
    year: number,
    month: number
  ) {
    const start_timestamp = new Date(Date.UTC(year, month - 1)).getTime();
    const end_timestamp = new Date(Date.UTC(year, month)).getTime();

    const values = await db.query(
      "\
    select avg(meter_values.value) y, date_trunc('day', to_timestamp(meter_values.time/1000)::timestamp) as x\
    from meter_values \
    where meter_id=$1 and time>$2 and time<$3\
    group by x\
    order by x\
    ",
      [meter_id, start_timestamp, end_timestamp]
    );
    return values.rows;
  }

  //получить средние показатели за день
  async getMeterValueByMeterId_AvgWeek(
    meter_id: number,
    year: number,
    month: number
  ) {
    const start_timestamp = new Date(Date.UTC(year, month - 1)).getTime();
    const end_timestamp = new Date(Date.UTC(year, month)).getTime();

    const values = await db.query(
      "\
    select avg(meter_values.value) y, date_trunc('week', to_timestamp(meter_values.time/1000)::timestamp) as x\
    from meter_values \
    where meter_id=$1 and time>$2 and time<$3\
    group by x\
    order by x\
    ",
      [meter_id, start_timestamp, end_timestamp]
    );
    return values.rows;
  }

  async getMeterValueByMeterId(meter_id: number, time: string, count: number) {
    const values = await db.query(
      "SELECT to_timestamp(meter_values.time/1000)::timestamp x, meter_values.value y\
      FROM meter_values \
      WHERE meter_id = $1 and time>$2\
      order by meter_values.time\
      limit $3",
      [meter_id, time, count]
    );
    if (values.rowCount === 0) {
      return [];
    }
    return values.rows;
  }


  async createMeterValue(
    meter_id: number,
    time: number|null,
    value: number,
  ) {


    const newValue = await db.query(
      "INSERT INTO meter_values (meter_id, time, value) \
      VALUES ($1, $2, $3) RETURNING *",
      [meter_id, time, value]
    );

    return newValue.rows[0];
  }

  async updateMeterValue(
    measurement_id: number,
    meter_id: number,
    time: number,
    value: number
  ) {
    const findValue = await db.query(
      "SELECT * FROM meter_values \
      WHERE measurement_id = $1",
      [measurement_id]
    );
    if (findValue.rowCount === 0) {
      throw new Error("invalid index (measurement_id)");
    }

    const newValue = await db.query(
      "UPDATE meter_values SET  meter_id = $2, \
      time = $3, value = $4 WHERE measurement_id = $1 RETURNING *",
      [measurement_id, meter_id, time, value]
    );

    return newValue.rows[0];
  }

  async deleteMeterValue(measurement_id: number) {
    const findValue = await db.query(
      "SELECT * FROM meter_values \
      WHERE measurement_id = $1",
      [measurement_id]
    );
    if (findValue.rowCount === 0) {
      throw new Error("invalid index (measurement_id)");
    }

    const value = await db.query(
      "DELETE FROM meter_values WHERE measurement_id = $1 RETURNING *",
      [measurement_id]
    );

    return value.rows[0];
  }
}

export const apidb = new APIDB();
