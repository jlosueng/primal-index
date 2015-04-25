Meteor.methods({
  sendResults:  (email, name, results, answers, pi, opt_in) ->
    Emails.update({email: email}, {email: email, name:name, verified: false, opt_in: opt_in}, {upsert: true})

    message = "<html><head></head><body>" + name + ",<p>Please find below the results of your recent Primal Index survey.</p>"
    message += "<h1>Your Primal Index Score is " + pi + " out of 100</h1>"
    message += "<p>The score was calculated based on the following answers to these questions</p>"
    message += "<ul>"

    for k of answers
      question = Questions.findOne({_id:  k})
      message += "<li>" + question.question + " : " + answers[k] + "</li>"

    message += "</ul>"
    check([email, message], [String])

    # Let other method calls from the same client start running,
    # without waiting for the email sending to complete.
    this.unblock()
    Email.send({
      to: email,
      from: 'The Primal Index <do-not-reply@primalindex.com>',
      subject: 'Your Primal Index Results',
      html: message
    })
  ,
  validateEmail:  (email, name) ->
    Email.send({
      to: email,
      from: 'The Primal Index <do-not-reply@primalindex.com>',
      subject: 'Verify Your Email',
      html: "<html><head></head><body>" + name + ",<br>Please click the link below to verify your request to receive updates from The Primal Index.</body></html>"
    })
})