import express from 'express';
// import * as model from '../models/model_PG.js';

const router = express.Router();
let renderSignUpPage = function (req, res) {
    res.render('signUp', {layout:'main'});
  }

router.route('/signup').get(renderSignUpPage);
export default router;