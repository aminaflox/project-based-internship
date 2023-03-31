import express from 'express';
import {engine} from 'express-handlebars';
import path from 'path';
//import cookieParser from 'cookie-parser';
import passport from 'passport';
import session from 'express-session';
import routes from './routes/routes.js';
import auth from './routes/auth.js';
import { fileURLToPath } from 'node:url';

const app = express();
let port = '3000';
const server = app.listen(port, () => { console.log("Awaiting request at port " + port) });
