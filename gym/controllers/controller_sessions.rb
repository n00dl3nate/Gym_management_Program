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

get '/sessions/new' do
  erb(:"sessions/new")
end

post '/sessions' do
  @session = Session.new(params)
  @session.save()
  redirect to("/sessions")
end

get '/sessions/:id' do
  id = params[:id].to_i
  @session = Session.find(id)
  @bookings = Member.show_bookings(params[:id].to_i)
  erb(:"sessions/show")
end
