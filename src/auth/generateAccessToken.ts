import jwt from "jsonwebtoken";

import { secret } from "../config";

interface IPayload {
  user_id: number;
  role: string;
  name: string;
}

export const generateAccessToken = (payload: IPayload) =>
  jwt.sign(payload, secret.key, { expiresIn: "180d" });
