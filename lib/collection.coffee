exports = this
exports.Questions = new Meteor.Collection("questions")
exports.Emails = new Meteor.Collection("emails")
exports.Schema = {}

Schema.Answers = new SimpleSchema({
  answer:
    type: String
    max: 50
  score:
    type: Number
})

Schema.Questions = new SimpleSchema({
  question:
    type: String
    max: 100
  max_score:
    type: Number
  answers:
    type: [Schema.Answers]
})



Questions.attachSchema(Schema.Questions)

