Meteor.publish('questions', ->
  Questions.find()
)

if (Questions.find().count() == 0)
  console.log(Questions.find().count())
  Questions.insert(
    {
      question: "How often do you eat meat?"
      answers: [
        {
          answer: "Once a week"
          score: 1
          questionID: "question1"
        },
        {
          answer: "Twice a week"
          score: 2
          questionID: "question1"

        },
        {
          answer: "3 or more times a week"
          score: 5
          questionID: "question1"
        }
      ]
    }
  )
  Questions.insert(
    {
      question: "How often do you do a sprint workout?"
      answers: [
        {
          answer: "Once a week"
          questionID: "question2"
          score: 5
        },
        {
          answer: "Twice a week"
          questionID: "question2"
          score: 10
        },
        {
          answer: "3 or more times a week"
          questionID: "question2"
          score: -1
        }
      ]
    }
  )
  Questions.insert(
    {
      question: "How often do you lift heavy?"
      answers: [
        {
          answer: "Once a week"
          questionID: "question3"
          score: 5
        },
        {
          answer: "Twice a week"
          questionID: "question3"
          score: 10
        },
        {
          answer: "3 or more times a week"
          questionID: "question3"
          score: -1
        }
      ]
    }
  )
  Questions.insert(
    {
      question: "Your favorite grain is:"
      answers: [
        {
          answer: "Rice"
          questionID: "question4"
          score: 2
        },
        {
          answer: "Corn"
          questionID: "question4"
          score: -10
        },
        {
          answer: "Quinoa"
          score: 4
          questionID: "question4"
        },
        {
          answer: "Grains? I don't need no stinkin' grains!"
          score: 10
          questionID: "question4"
        }
      ]
    }
  )
