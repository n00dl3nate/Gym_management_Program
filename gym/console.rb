require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/controller_members')
require_relative('controllers/controller_sessions')
require_relative('controllers/controller_bookings')
require_relative('controllers/controller_timetables')


get '/' do
  erb( :index )
end
