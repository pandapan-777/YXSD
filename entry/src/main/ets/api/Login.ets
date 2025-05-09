import { Http } from "basic"
import { AccountForModel } from "../models"


export const LoginApi=(data:AccountForModel):Promise<string>=>{
  return Http.post<string>("/login/account",data)
}