#Gems to require in!
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
#Files to require
require_relative('../models/members.rb')
require_relative('../models/booking.rb')
require_relative('../models/sessions.rb')
require_relative('../models/timetable.rb')
also_reload( '../models/*' )

get '/members' do
  @members = Member.all()
  erb (:"members/index")
end

get '/members/search' do
  @members = Member.all()
  erb(:"members/search")
end

get '/members/search/:name' do
  search = params[:name].to_s
  @members = Member.all()
  @member = Member.search_by_name(search)
  erb(:"members/results")
end

get '/members/new' do
  erb(:"members/new")
end

post '/members' do
  @new_member = Member.new(params)
  @new_member.save()
  redirect to("/members")
end

get '/members/:id' do
  id = params[:id].to_i
  @member = Member.find(id)
  @bookings = Member.show_bookings(params[:id].to_i)
  erb(:"members/show")
end

post '/members/:id/delete' do
  id = params[:id].to_i
  member = Member.find(id)
  member.delete()
  redirect to("/members")
end

get '/members/:id/new_booking' do
  id = params[:id].to_i
  @member = Member.find(id)
  @timetables = Timetable.show_class_times
  @bookings = Member.show_bookings(id)
  erb(:"bookings/new")
end

post '/members/:id/update' do
  @member = Member.find(params[:id].to_i)
  erb(:"members/update")
end

post '/members/:id/change' do
  updated_member = Member.new(params)
  updated_member.update()
  @members = Member.all()
  redirect to("/members")
end
