import express from 'express';
//import * as model from '../models/model_PG.js';

const router = express.Router();
let renderSignup = function (req, res) {
  res.render('signup', {layout:'main',user: req.user});
}

let renderIndex = function(req, res) {
  res.render('index', {layout: 'main'});
}

let renderSignin = function(req, res){
  res.render('signin', {layout: 'main'})
}

let renderSearch = function(req, res){
  res.render('search', {layout: 'main'})
}

let renderAbout = function(req, res){
  res.render('about', {layout: 'main'})
}

let renderFaqs = function(req, res){
  res.render('faqs', {layout: 'main'})
}

let renderProfile = function(req, res){
  res.render('profile', {layout: 'main'})
}

let renderInform = function(req, res){
  res.render('inform', {layout: 'main'})
}

router.route('/').get(renderIndex);
router.route('/signin').get(renderSignin);
router.route('/search').get(renderSearch);
router.route('/about').get(renderAbout);
router.route('/faqs').get(renderFaqs);
router.route('/profile').get(renderProfile);
router.route('/inform').get(renderInform);
router.route('/signup').get(renderSignup);


export default router;