import express from 'express';
import passport from 'passport';
import LocalStrategy from 'passport-local';
import crypto from 'crypto';
import * as model from '../models/model_PG.js';

passport.use(new LocalStrategy(
{usernameField:'email',passwordField:'password'},
function verify(email, password, cb) { 
  
  model.findUser(email, function(err, row) {
  if (err) { return cb(err); }
  if (!row) { return cb(null, false, { message: 'Incorrect email or password.' }); }
  const ourSalt = new Buffer.from(row[0].salt, "hex");
  crypto.pbkdf2(password, ourSalt, 310000, 32, 'sha256', function(err, hashedPassword) {
    if (err) { return cb(err); }
    const ourPass = new Buffer.from(row[0].password, "hex");
    if (!crypto.timingSafeEqual(ourPass, hashedPassword)) {
      return cb(null, false, { message: 'Incorrect username or password.' });
    }
    return cb(null, row);
  });
})
}));
const router = express.Router();

passport.serializeUser(function(row, cb) {
  const user = row[0];
  let admin = false;
  if(row[1]){
    admin = true;
  }
  return process.nextTick(function() {
    cb(null, { userID: user.userID,admin: admin ,email: user.email, password: user.password, firstName: user.firstName, lastName: user.lastName, city: user.city, streetAddrs: user.streetAddrs, numberAddrs: user.numberAddrs, bdate: user.bdate, age: user.age, gender: user.gender, phonenumber: user.phonenumber, salt: user.salt });
  });
});

passport.deserializeUser(function(user, cb) {
  return process.nextTick(function() {
    return cb(null, user);
  });
});

router.route('/signin').get(function (req, res) {
  res.render('signin', {layout:'main'});
});

router.post('/signin/password', 
  passport.authenticate('local', { failureRedirect: '/signin', failureMessage: true }),
  function(req, res) {
    res.redirect('/');
  });
  router.route('/signup').get(function (req, res) {
    res.render('signup', {layout:'main'});
  })

router.route("/signup").post((req,res)=>{
    let salt = crypto.randomBytes(16);
    let userID=null;
    let email=req.body.email;
    let firstName=req.body.firstName;
    let lastName=req.body.lastName;
    let city=req.body.city;
    let streetAddrs=req.body.streetAddrs;
    let numberAddrs=req.body.numberAddrs;
    let bdate=req.body.bdate;
    let age=req.body.age;
    let gender=req.body.gender;
    let phonenumber=req.body.phonenumber;
    
    

    crypto.pbkdf2(req.body.password, salt, 310000, 32, 'sha256',function(err,hashedPassword){
      if(err){return nextTick(err);}
        model.insertUser(email,hashedPassword.toString("hex"),firstName,lastName,city,streetAddrs,numberAddrs,bdate,age,gender,phonenumber,salt.toString('hex'),(error,row)=>{
          if(error){
            console.log(error);
          }
          else{
            res.redirect("/");
        
        }
      });
      
    })
  })
  

  export default router;