
const passport = require('passport')

exports.onlyAuthUser = passport.authenticate('jwt', {session: false})
