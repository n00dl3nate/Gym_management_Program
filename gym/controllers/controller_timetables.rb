#Gems to require in!
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
#Files to require
require_relative('../models/timetable.rb')
also_reload( '../models/*' )

get '/timetables' do
  @timetables = Timetable.all()
  erb (:"timetables/index")
end
