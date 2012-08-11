require 'redis-namespace'

module Runlimited
	# This class is an implementation of a limiter which stores its
	# limit information in a Redis database
	class Redis < Base
		# The Redis key in which to store our last request info
		attr_reader :redis_key

		# When instanciating a new Redis limiter the user must provide a few pieces of information
		#
		# @param options [Redis] :redis (Redis.new) An instance of the Redis client
		# @param options [Integer] :interval (5) The minimum wait time between requests
		# @param options [String] :key (lastrequest) The Redis key in which to store the last request info (namespaced to 'runlimited')
		def initialize( options = {} )
			super(options)
			redis = options[:redis] || ::Redis.new
			@redis = ::Redis::Namespace.new(:runlimited, :redis => redis)
			@redis_key = options[:key] || 'lastrequest'
		end

		# Fetch the last request Time
		def last_run
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
