require 'spec_helper'
require 'redis'

describe Somelimited do
	describe "Redis" do
		before do
			redis_config = {
				:host => 'localhost',
				:port => '6379'
			}

			@limiter = Somelimited::Redis.new(5, redis_config)
			@redis = Redis.new(redis_config)
		end

		it "inherits from the base implementation" do
			@limiter.must_be_instance_of Somelimited::Redis
			@limiter.must_be_kind_of Somelimited::Base
		end

	  it "stores to a redis key exposed as #redis_key" do
			@limiter.must_respond_to :redis_key
			@limiter.redis_key.wont_be_nil
			@limiter.redis_key.must_be_instance_of String
		end

		it "retrieves the last update from Redis" do
			@redis.set( @limiter.redis_key, Time.at(0).to_i )
			time = @limiter.last_request

			time.must_be_instance_of Time
			time.must_equal Time.at(0)
		end

		it "stores the last update in Redis and return the updated time" do
			time = Time.new
			Time.expects(:new).returns(time)

			retval = @limiter.update
			retval.must_equal time
			time.to_i.must_equal @redis.get( @limiter.redis_key ).to_i
		end
	end
end
