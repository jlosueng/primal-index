Meteor.methods({
  sendResults:  (email, name, results, answers, pi) ->
    Emails.update({email: email}, {email: email, name:name, verified: false, opt_in: true}, {upsert: true})

    message = "<html><head></head><body>" + name + ",<p>Please find below the results of your recent Primal Index survey.</p>"
    message += "<h1>Your Primal Index Score is " + pi + "</h1>"
    message += "<p>The score was calculated based on the following answers to these questions</p>"
    message += "<ul>"

    for k of answers
      question = Questions.findOne({answers: { $elemMatch : {questionID: k}}}, {fields: {question: true, _id: false}})
      message += "<li>" + question.question + " : " + answers[k] + "</li>"

    message += "</ul>"
    Email.send({
      to: email,
      from: 'The Primal Index <jlofshult@gmail.com>',
      subject: 'Your Primal Index Results',
      html: message
    })
  ,
  validateEmail:  (email, name) ->
    Email.send({
      to: email,
      from: 'The Primal Index <jlofshult@gmail.com>',
      subject: 'Verify Your Email',
      html: "<html><head></head><body>" + name + ",<br>Please click the link below to verify your request to receive updates from The Primal Index.</body></html>"
    })
})