#Gems to require in!
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
#Files to require
require_relative('../models/sessions.rb')
require_relative('../models/timetable.rb')
also_reload( '../models/*' )

get '/timetables' do
  @timetables = Timetable.show_class_times()
  erb (:"timetables/index")
end


get '/timetables/new' do
  @sessions = Session.all
  erb(:"timetables/new")
end

post '/timetables' do
  @timetable = Timetable.new(params)
  @timetable.save()
  redirect to("/timetables")
end

post '/timetables/:id/delete' do
  id = params[:id].to_i
  Timetable.delete(id)
  redirect to("/timetables")
end
