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

post ('/bookings/:id/delete') do
  id = params[:id].to_i
  Booking.delete_find(id)
  redirect to('/members')
end
