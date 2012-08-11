require 'spec_helper'
require 'redis'
require 'mock_redis'

describe Runlimited do
	describe "Redis" do
		before do
			@redis_key = 'runlimited:lastrequest'
			@redis = MockRedis.new
			@limiter = Runlimited::Redis.new( :redis => @redis )
		end

		it "inherits from the base implementation" do
			@limiter.must_be_instance_of Runlimited::Redis
			@limiter.must_be_kind_of Runlimited::Base
		end

		it "retrieves the last update from Redis" do
			preset = Time.local( 1983, 8, 7, 8, 30, 0 )

			@redis.set( @redis_key, preset.to_i )

			time = @limiter.last_run
			time.must_be_instance_of Time
			time.must_equal preset
		end

		it "stores the last update in Redis and return the updated time" do
			time = Time.at(12345)
			
			Timecop.freeze( time ) do
				retval = @limiter.update
				time.to_i.must_equal @redis.get( @redis_key ).to_i
			end
		end
	end
end
