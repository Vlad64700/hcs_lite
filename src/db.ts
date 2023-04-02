import { Pool } from "pg";

// конфиг Влада
// export const pool = new Pool({
//   user: "vlad",
//   password: "Good2001",
//   host: "localhost",
//   port: 5432,
//   database: "SMART_HCS",
// });

// конфиг Данила
// export const pool = new Pool({
//   user: "postgres",
//   password: "root",
//   host: "localhost",
//   port: 5432,
//   database: "smarthcs",
// });

//конфиг сервера cloud nstu
export const pool = new Pool({
  user: "smarthcs",
  password: "smarthcs2022",
  host: "localhost",
  port: 5432,
  database: "hcs_lite",
});
