const passport = require('passport');
const LocalStrategy = require('passport-local');
const User = require('../models/users');
const config = require('../config');
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;

passport.use(new LocalStrategy({
  usernameField: 'email',
  passwordField: 'password'
}, (email, password, done) => {
  User.findOne({email}, function(err, user) {
    if (err) { return done(err); }
    if (!user) { return done(null, false) }

    user.comparePassword(password, function(err, isMatch) {
      if (err) { return done(err); }
      if (!isMatch) { return done(null, false) }

      return done(null, user)
    })
  })
}))


const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: config.JWT_SECRET
};

passport.use(new JwtStrategy(jwtOptions, function(payload, done) {
  User.findById(payload._id, function (err, user) {
    if (err) { return done(err, false)}

    if (user) {
      done(null, user);
    } else {
      done(null, false)
    }
  });
}));












