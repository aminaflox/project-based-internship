// import { model } from 'auth/lib/models/token';
import express from 'express';
import * as model from '../models/model_PG.js';

const router = express.Router();

//SIGNUP
let renderSignup = function (req, res) {
  res.render('signup', {layout:'main',user: req.user});
} 
//ABOUT
let renderAbout = function(req, res){
  res.render('about', {layout: 'main',user: req.user})
}
//FAQS
let renderFaqs = function(req, res){
  res.render('faqs', {layout: 'main',user: req.user})
}
//PROFILE
let renderProfile = function(req, res){
  res.render('profile', {layout: 'main',user: req.user})
}



//INDEX
let renderIndex = function(req, res) {
  if(!req.user){
    return res.render('index',{layout:'main',user:null})
  }
  res.render('index', {layout: 'main',user: req.user});
};

//SEARCH
let renderSearch = function(req, res){
  model.findFlights(req.query.journeyID, req.query.departFrom, req.query.arriveTo, req.query.departureDate, req.query.arrivalDate, (err, flights) => { 
    res.render('search', {layout: 'main',user: req.user, formData: req.query, flights: flights})
  })
};

//SELECT
let renderSelect = function(req, res){
  res.render('select', {layout: 'main', user: req.user, formData: req.query})
};

//INFORM  AND  /SEARCH/PASSENGER
let renderInform = function(req, res){
  const passengerCount= req.query.passengers ? req.query.passengers.slice(0,1) : 0;
  const passengers= [];

  for(let i=0;i<passengerCount;i++){
    passengers.push(i);
  }
  console.log(passengers, req.query, passengerCount)
  res.render('inform', {layout: 'main',user: req.user, formData: req.query, passengers: passengerCount})
};

//CONFIRMATION
let renderConfirmation=function(req,res){
  console.log(req.session.passport.user.userID,req.body);
  model.createTicketPassengerRelation(req.session.passport.user.userID,req.body, function(err,passenger) {
    return res.render('confirmation',{layout:'main',user: req.user})
  });
}

//MYBOOKING
let renderBooking=function(req,res){
  model.checkBookingID(req.query.bookID,req.userID,req.journeyID, function(err, bookings){
    return res.render('myBooking', {layout:'main', user:req.user, bookings: bookings})
  })
};



router.route('/').get(renderIndex);
router.route('/search').get(renderSearch);
router.route('/search/passenger').post(renderInform);
router.route('/search/passenger/confirmation').post(renderConfirmation);
router.route('/about').get(renderAbout);
router.route('/faqs').get(renderFaqs);
router.route('/profile').get(renderProfile);
router.route('/signup').get(renderSignup);
router.route('/myBooking').get(renderBooking);
router.route('/select').get(renderSelect);


export default router;


// router.route('/search/inform').post(renderInform);
// router.route('/search/inform/confirmation').post(renderConfirmation);