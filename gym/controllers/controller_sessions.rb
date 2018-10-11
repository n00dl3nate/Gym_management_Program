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
  @timetables = Session.times(id)
  erb(:"sessions/show")
end

post '/sessions/:id/delete' do
  id = params[:id].to_i
  session = Session.find(id)
  session.delete()
  redirect to("/sessions")
end

post '/sessions/:id/update' do
  id = params[:id].to_i
  @session = Session.find(id)
  erb(:"sessions/update")
end

post '/sessions/:id/change' do
  updated_session = Session.new(params)
  updated_session.update()
  @session = Session.all
  redirect to('/sessions')
end
