import express from 'express';
//import * as model from '../models/model_PG.js';

const router = express.Router();
let renderSignup = function (req, res) {
  res.render('signup', {layout:'main',user: req.user});
}

let renderIndex = function(req, res) {
  if(!req.user){
    return res.render('index',{layout:'main',user:null})
  }
  res.render('index', {layout: 'main',user:req.user});
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
router.route('/search').get(renderSearch);
router.route('/about').get(renderAbout);
router.route('/faqs').get(renderFaqs);
router.route('/profile').get(renderProfile);
router.route('/inform').get(renderInform);
router.route('/signup').get(renderSignup);


export default router;