require "active_record"

#or import models from a file or gem
class SomeMode < ActiveRecord::Base
end

def lambda_handler(event:, context:)
  ActiveRecord::Base.establish_connection (
    :adapter  => "postgresql",
    :host     => ENV["host"],
    :username => ENV["user"],
    :password => ENV["password"],
    :database => ENV["database"]
  )
  { statusCode: 200, body: SomeModel.first }
end