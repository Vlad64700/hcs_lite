import express from "express";
import { SensorsCountersController } from "../Controllers/sensorsCountersController";
import { authMiddleware } from "../middleware/authMiddleware";
import { roleMiddlewareFitter } from "../middleware/roleMiddleware";

const sensorsCountersRouter = express.Router();
const sensorsCountersController = new SensorsCountersController();

sensorsCountersRouter.get(
  "/",
  authMiddleware,
  sensorsCountersController.getSensors
);
sensorsCountersRouter.get(
  "/:meter_id",
  authMiddleware,
  sensorsCountersController.getSensorByMeterId
);
sensorsCountersRouter.get(
  "/user/:user_id",
  authMiddleware,
  sensorsCountersController.getSensorsByUserId
);

sensorsCountersRouter.post(
  "/",
  roleMiddlewareFitter,
  sensorsCountersController.createSensor
);

sensorsCountersRouter.put(
  "/",
  roleMiddlewareFitter,
  sensorsCountersController.updateSensor
);

sensorsCountersRouter.delete(
  "/:meter_id",
  roleMiddlewareFitter,
  sensorsCountersController.deleteSensor
);

export { sensorsCountersRouter };
