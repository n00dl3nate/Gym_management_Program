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
  booking = Booking.find(id)

  timetable_id = booking.timetable_id.to_i
  member_id = booking.member_id.to_i


  Timetable.add(timetable_id)

   @timetable = Timetable.find(timetable_id)
   @member    = Member.find(member_id)

   session_id = @timetable.session_id.to_i

   @session = Session.find(session_id)

  Booking.delete_find(id)
  erb(:"bookings/deleted")

end

post ('/bookings/:id/:timetable_id') do

  member_id = params[:id]
  timetable_id = params[:timetable_id]

  @member = Member.find(member_id)
  @timetable = Timetable.find(timetable_id)

  session_id = @timetable.session_id.to_i
  @session = Session.find(session_id)

  booking_new = Booking.new(
    "member_id" => member_id,
    "timetable_id" => timetable_id
  )
  Timetable.subtract(timetable_id)

  booking_new.save
  erb(:"bookings/created")
end
