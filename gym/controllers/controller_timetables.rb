#Gems to require in!
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
#Files to require
require_relative('../models/sessions.rb')
require_relative('../models/timetable.rb')
require_relative('../models/members.rb')
require_relative('../models/booking.rb')
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

  @timetable = Timetable.find(id)

  session_id = @timetable.session_id.to_i
  @session = Session.find(session_id)

  Timetable.delete(id)

  erb(:"timetables/deleted")
end

get '/timetables/:id' do
  id = params[:id].to_i
  @timetable = Timetable.find(id)
  @members = Timetable.attendance(id)
  s_id = @timetable.session_id
  @session = Session.find(s_id)
  erb(:"timetables/show")
end

post '/timetables/:id/update' do
  id = params[:id].to_i
  @timetable = Timetable.find(id)
  @sessions = Session.all

  erb(:"timetables/update")
end

post '/timetables/:id/change' do
  updated_timetable = Timetable.new(params)
  update_member.update()
  @timetable = Timetable.all
  redirect to("/timetables")
end
