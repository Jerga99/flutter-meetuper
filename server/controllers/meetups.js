const Meetup = require('../models/meetups');
const User = require('../models/users');

exports.getSecret = function (req, res) {
  return res.json({secret: 'I am secret Message'})
}

exports.getMeetups = function(req, res) {
  const {category, location} = req.query;

  const findQuery = location ? Meetup.find({ processedLocation: { $regex: '.*' + location + '.*' } })
                             : Meetup.find({})
  findQuery
        .populate('category')
        .populate('joinedPeople')
        .populate('meetupCreator')
        .limit(100)
        .sort({'createdAt': -1})
        .exec((errors, meetups) => {
    if (errors) {
      return res.status(422).send({errors});
    }

    // WARNING: requires improvement, can decrease performance
    if (category) {
      meetups = meetups.filter(meetup => {
        return meetup.category.name === category
      })
    }

    return res.json(meetups);
  });
}

getMeetupByIdQuery = function(id, callback) {
  Meetup.findById(id)
        .populate('meetupCreator', 'name id avatar')
        .populate('category')
        .populate({path: 'joinedPeople',
           options: {limit: 5, sort: {username: -1}}})
        .exec(callback);
}

exports.getMeetupById = function(req, res) {
  const {id} = req.params;

  getMeetupByIdQuery(id, (errors, meetup) => {
    if (errors) {
      return res.status(422).send({errors});
    }

    return res.json(meetup);
  });
}

exports.createMeetup = function(req, res) {
  const meetupData = req.body;
  const user = req.user;

  const meetup = new Meetup(meetupData);
  meetup.meetupCreator = user;
  meetup.processedLocation = meetup.location.toLowerCase().replace(/[\s,]+/g,'').trim()
  meetup.status = 'active';

  meetup.save((errors, createdMeetup) => {
    if (errors) {
      return res.status(422).send({errors});
    }

    User.populate(createdMeetup, 'meetupCreator', function (err) {
      return res.json(createdMeetup._id);
    });
  });
}

exports.joinMeetup = function (req, res) {
  const user = req.user;
  const {id} = req.params;

  getMeetupByIdQuery(id, (errors, meetup) => {
    if (errors) {
      return res.status(422).send({errors})
    }

    const userIndex = meetup.joinedPeople.findIndex(p => p._id == user.id);
    if (userIndex != -1) {
      return res.status(422).send({errors: 'You are already member!'});
    }

    meetup.joinedPeople.push(user);
    meetup.joinedPeopleCount++;

    return Promise.all(
      [meetup.save(),
      User.updateOne({ _id: user._id }, { $push: { joinedMeetups: meetup }})])
      .then(result => {
        return res.json(meetup)
      })
      .catch(errors => res.status(422).send({errors}))
  });
}

exports.leaveMeetup = function (req, res) {
  const user = req.user;
  const {id} = req.params;

  getMeetupByIdQuery(id, (errors, meetup) => {
    if (errors) {
      return res.status(422).send({errors})
    }

    const userIndex = meetup.joinedPeople.findIndex(p => p._id == user.id);
    if (userIndex == -1) {
      return res.status(422).send({errors: 'You are not member of this meetup'});
    }

    meetup.joinedPeople.splice(userIndex, 1);
    meetup.joinedPeopleCount--;

    Promise.all(
      [Meetup.updateOne({ _id: id }, { $pull: { joinedPeople: user._id }, $inc: {joinedPeopleCount: -1}}),
       User.updateOne({ _id: user._id }, { $pull: { joinedMeetups: id }})])
      .then(result => {
        return res.json(meetup)
      })
      .catch(errors => res.status(422).send({errors}))
  });
}

// We were just debugging in this lecture (:
exports.updateMeetup = function (req, res) {
  const meetupData = req.body
  const {id} = req.params
  const user = req.user;
  meetupData.updatedAt = new Date()

  if (user._id === meetupData.meetupCreator._id) {
    Meetup.findByIdAndUpdate(id, { $set: meetupData}, { new: true })
          .populate('meetupCreator', 'name id avatar')
          .populate('category')
          .exec((errors, updatedMeetup) => {

      if (errors) {
        return res.status(422).send({errors})
      }

      return res.json(updatedMeetup)
    })
  } else {
    return res.status(401).send({errors: {message: 'Not Authorized!'}})
  }
}











