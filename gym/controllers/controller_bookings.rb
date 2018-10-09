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

get ('/bookings/new') do
  erb(:"booking/new")
end


# post '/bookings/new/:id' do
#   @new_booking = booking.new(params)
#   @new_booking.save()
#   redirect to("/members")
# end

post ('/bookings/:id/delete') do
  id = params[:id].to_i
  Booking.delete_find(id)
  redirect to('/members')
end


post '/booking/:id/:timetable_id' do
  id = params[:id].to_i
  timetable_id = params[:timetable_id].to_i
  booking_new = Booking.new(
    "member_id" => id,
    "timetable_id" => timetable_id
  )
  booking_new.save
  redirect to('/members')
end
