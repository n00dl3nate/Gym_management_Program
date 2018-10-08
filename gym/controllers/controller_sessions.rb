#Gems to require in!
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
#Files to require
require_relative('../models/sessions.rb')
also_reload( '../models/*' )

get '/sessions' do
  @sessions = Session.all()
  erb (:"sessions/index")
end
