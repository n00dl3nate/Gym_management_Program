require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/controller_members')


get '/' do
  erb( :index )
end
