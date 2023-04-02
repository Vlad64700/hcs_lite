import express from "express";
import { MeterValueController } from "../Controllers/meterValueController";
import { authMiddleware } from "../middleware/authMiddleware";

const meterValueRouter = express.Router();
const meterValueController = new MeterValueController();

meterValueRouter.get("/", authMiddleware, meterValueController.getValues);

meterValueRouter.get(
  "/user/:user_id",
  authMiddleware,
  meterValueController.getValuesByUserId
);

meterValueRouter.post(
  "/",
  authMiddleware,
  meterValueController.createMeterValue
);
meterValueRouter.post(
  "/meter",
  authMiddleware,
  meterValueController.getValuesByMeterId
);
//получение средних значений по годам
meterValueRouter.post(
  "/meter/avg/year",
  authMiddleware,
  meterValueController.getValuesByMeterIdAvgYear
);
meterValueRouter.post(
  "/meter/avg/month",
  authMiddleware,
  meterValueController.getValuesByMeterIdAvgMonth
);
meterValueRouter.post(
  "/meter/avg/week",
  authMiddleware,
  meterValueController.getValuesByMeterIdAvgWeek
);
meterValueRouter.post(
  "/meter/avg/day",
  authMiddleware,
  meterValueController.getValuesByMeterIdAvgDay
);

meterValueRouter.delete(
  "/:measurement_id",
  authMiddleware,
  meterValueController.deleteMeterValue
);

export { meterValueRouter };
