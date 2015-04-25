Meteor.publish('questions', ->
  Questions.find()
)

if (Questions.find().count() == 0)
  console.log(Questions.find().count())
  Questions.insert(
    {
      question: "How often do you eat meat?"
      max_score: 5
      answers: [
        {
          answer: "Once a week"
          score: 1
        },
        {
          answer: "Twice a week"
          score: 2
        },
        {
          answer: "3 or more times a week"
          score: 5
        }
      ]
    }
  )
  Questions.insert(
    {
      question: "How often do you do a sprint workout?"
      max_score: 10
      answers: [
        {
          answer: "Once a week"
          score: 5
        },
        {
          answer: "Twice a week"
          score: 10
        },
        {
          answer: "3 or more times a week"
          score: -1
        }
      ]
    }
  )
  Questions.insert(
    {
      question: "How often do you lift heavy?"
      max_score: 10
      answers: [
        {
          answer: "Once a week"
          score: 5
        },
        {
          answer: "Twice a week"
          score: 10
        },
        {
          answer: "3 or more times a week"
          score: -1
        }
      ]
    }
  )
  Questions.insert(
    {
      question: "Your favorite grain is:"
      max_score: 10
      answers: [
        {
          answer: "Rice"
          score: 2
        },
        {
          answer: "Corn"
          score: -10
        },
        {
          answer: "Quinoa"
          score: 4
        },
        {
          answer: "Grains? I don't need no stinkin' grains!"
          score: 10
        }
      ]
    }
  )
