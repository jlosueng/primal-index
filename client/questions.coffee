Meteor.subscribe('questions')
Meteor.subscribe('emails')
scores = {}
answers = {}

Template.questions.helpers(
   'questions':  ->
     Questions.find()
 )

Template.questions.events(
  'click #submit' : (e) ->
    primalIndex = 0
    e.preventDefault()
    maxScore = getMaxScore()
    for k, v of scores
      primalIndex += parseInt(v)
    Session.set('primalIndex', Math.round(100*primalIndex/maxScore))
    Router.go('results')

  'click input:radio' : (e) ->
    value = $(e.target).val()
    answer = $(e.target).data('answer')
    elName = $(e.target).attr('name')
    scores[elName] = value
    answers[elName] = answer
)

Template.login.events(

  'click #login-button' : (e) ->
    e.preventDefault()
    email = $('#login-email').val()
    password = $('#login-password').val()
    Meteor.loginWithPassword(email, password, (e) ->
      if (e)
        sweetAlert {title: "Oops", text: "There was a problem with your login. Please try again.", type: "error"}
      else
        Router.go('/admin')
    )
  ,
  'click #cancel-login-button' : (e) ->
    e.preventDefault()
    $('#login-form-div').hide()
)

Template.home_page.events(
  'click .btn' : (e) ->
    e.preventDefault()
    Router.go('questions')
)

Template.results.helpers(
  'primalIndex': ->
    Session.get('primalIndex')
)

Template.results.events (
  'click button' : (e) ->
    name = $('#formName').val()
    email = $('#formEmail').val()
    email2 = $('#formEmail2').val()
    primalIndex = Session.get('primalIndex')
    check(name, String)
    check(email, String)
    check(email2, String)

    if (name.length == 0)
      sweetAlert("Please enter your first name")
      $('#formName').addClass("error")
      error = true
    else
      $('#formName').removeClass("error")


    emailPat = new RegExp("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$")
    if (!emailPat.test(email.toUpperCase()))
      sweetAlert("Email address isn\'t in the proper format")
      $('#formEmail').addClass("error")
      error = true
    else if (email == email2)
      $('#formEmail').removeClass("error")

    if (!emailPat.test(email2.toUpperCase()))
      sweetAlert("Email address isn\'t in the proper format")
      $('#formEmail2').addClass("error")
      error = true
    else if (email == email2)
      $('#formEmail2').removeClass("error")


    if (email != email2)
      sweetAlert("Emails don't match")
      $('#formEmail').addClass("error")
      $('#formEmail2').addClass("error")
      error = true

    if error
      Session.set('primalIndex', primalIndex)
      Router.go('results')
    else
      checkboxChecked = $('#formCheckbox').is(':checked')
      e.preventDefault()

      if (checkboxChecked)
        opt_in = true
      else
        opt_in = false

      Meteor.call('sendResults', email, name, scores, answers, primalIndex, opt_in)
      #  Meteor.call('validateEmail', email, name)
      Router.go('thankYou')
)


getMaxScore = ->
  maxScore = 0
  maxScores = Questions.find({}, {fields: {max_score: true, _id: false}}).fetch()
  for objScore in maxScores
    maxScore += objScore.max_score
  return maxScore