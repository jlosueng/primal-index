Meteor.subscribe('questions')
Meteor.subscribe('emails')
scores = {}
answers = {}

Template.questions.helpers(
   'questions': ->
     Questions.find({})
   )

Template.questions.events(
  'click #submit' : (e) ->
    primalIndex = 0
    e.preventDefault()
    for k, v of scores
      primalIndex += parseInt(v)
    Session.set('primalIndex', primalIndex)
    Router.go('results')

  'click input:radio' : (e) ->
    value = $(e.target).val()
    answer = $(e.target).data('answer')
    elName = $(e.target).attr('name')
    scores[elName] = value
    answers[elName] = answer
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
    if (email != email2)
      alert("Emails don't match")
    checkboxChecked = $('#formCheckbox').is(':checked')
    e.preventDefault()
    Meteor.call('sendResults', email, name, scores, answers, primalIndex)
    if (checkboxChecked)
      Meteor.call('validateEmail', email, name)

    Router.go('thankYou')
)