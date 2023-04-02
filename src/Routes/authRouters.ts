import express from "express";

import { AuthController } from "../Controllers/authController";
import { roleMiddlewareAdmin } from "../middleware/roleMiddleware";

const authRouter = express.Router();
const authController = new AuthController();

authRouter.post("/registration", authController.registration);
authRouter.post("/login", authController.login);

export { authRouter };
