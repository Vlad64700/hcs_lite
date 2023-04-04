import express from "express";
import { UsersController } from "../Controllers/usersController";
import { authMiddleware } from "../middleware/authMiddleware";
import { roleMiddlewareAdmin } from "../middleware/roleMiddleware";

const usersRouter = express.Router();
const usersController = new UsersController();

usersRouter.get("/", roleMiddlewareAdmin, usersController.getUsers);
usersRouter.get("/:id", authMiddleware, usersController.getOneUser);
usersRouter.get(
  "/get/pending",
  roleMiddlewareAdmin,
  usersController.getPendingUsers
);
usersRouter.get(
  "/get/roles",
  roleMiddlewareAdmin,
  usersController.getUserRoles
);

usersRouter.post("/", usersController.createUser);

usersRouter.put("/", roleMiddlewareAdmin, usersController.updateUser);
usersRouter.put(
  "/updateRole",
  roleMiddlewareAdmin,
  usersController.updateUserRole
);
usersRouter.put(
  "/updateProfile",
  roleMiddlewareAdmin,
  usersController.updateUserProfile
);
usersRouter.put(
  "/updatePassword",
  roleMiddlewareAdmin,
  usersController.updateUserPassword
);
usersRouter.delete("/:id", roleMiddlewareAdmin, usersController.deleteUser);

export { usersRouter };
