#Gems to require in!
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
#Files to require
require_relative('../models/members.rb')
require_relative('../models/sessions.rb')
require_relative('../models/timetable.rb')
require_relative('../models/booking.rb')
also_reload( '../models/*' )

get '/Members' do
end
