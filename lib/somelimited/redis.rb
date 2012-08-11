module Somelimited
	# This class is an implementation of a limiter which stores its
	# limit information in a Redis database
	class Redis < Base
		# The Redis key in which to store our last request info
		attr_reader :redis_key

		# When instanciating a new Redis limiter the user must provide a few pieces of information
		#
		# * The wait interval in seconds
		# * A redis config hash in the form { :host => 'hostname', :port => 1234 }
		# * (Optional) the Redis key name in which to store our data
		def initialize( interval, config, key = 'somelimited_lastrequest' )
			super(interval)
			@redis = ::Redis.new( config )
			@redis_key = key
		end

		# Fetch the last request Time
		def last_request
			stamp = @redis.get( redis_key )
			Time.at(stamp.to_i)
		end

		# Update the last request in Redis and return the Time
		def update
			stamp = Time.new
			@redis.multi do
				@redis.set( redis_key, stamp.to_i )
			end

			return stamp
		end
	end
end
