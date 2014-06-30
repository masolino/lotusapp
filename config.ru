require_relative 'apps/frontend/application'
require_relative 'apps/backend/application'

run Lotus::Router.new {
  mount Backend::Application,  at: '/backend'
  mount Frontend::Application, at: '/'
}
