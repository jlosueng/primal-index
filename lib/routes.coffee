Router.configure(
  layoutTemplate: 'layout'
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'
  yieldRegions: {
    'sidenav' : {to: 'sidenav'},
    'fixedFooter': {to: 'footer'},
    'navbar': {to: 'navbar'}
  }
)

Router.onBeforeAction('loading')

Router.route('/',  'home_page')

Router.route('register')
Router.route('about')
Router.route('questions')
Router.route('results')
Router.route('thankYou')
