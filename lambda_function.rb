require "active_record"

class SomeMode < ActiveRecord::Base
end

def lambda_handler(event:, context:)
  ActiveRecord::Base.establish_connection (
    :adapter  => "postgresql",
    :host     => "host.com",
    :username => "user",
    :password => "password",
    :database => "database"
  )
  { statusCode: 200, body: SomeModel.first }
end