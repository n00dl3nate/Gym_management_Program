require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/controller_members')
require_relative('controllers/controller_sessions')
require_relative('controllers/controller_bookings')


get '/' do
  erb( :index )
end
