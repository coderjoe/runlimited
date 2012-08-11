require 'spec_helper'

describe Runlimited do
  describe "Base" do
    before do
      @ratelimiter = Runlimited::Base.new
    end

    it "exposes a class" do
			Runlimited::Base.must_be_instance_of Class
    end

    it "accepts an options array including an interval #interval" do
      s = Runlimited::Base.new( :interval => 1 )
      s.must_respond_to :interval
      s.interval.must_equal 1
    end

    it "defaults #interval to 5 seconds" do
			Runlimited::Base.new.interval.must_equal 5
    end

		describe '#last_run' do
			it "returns the time of the last run" do
				@ratelimiter.must_respond_to :last_run
				@ratelimiter.last_run.must_be_instance_of Time
			end
		end

		describe '#update' do
			it "updates the last request on #update" do
				@ratelimiter.must_respond_to :update

				time = Time.local(1983,8,7,8,30,0)
				Timecop.freeze( time ) do
					@ratelimiter.update
				end

				@ratelimiter.last_run.must_equal time
			end
		end

		describe "#limited" do
			it "returns a boolean" do
				@ratelimiter.must_respond_to :limited?
				true.must_equal @ratelimiter.limited?.is_a?(TrueClass) || @ratelimiter.limited?.is_a?(FalseClass)
			end

			it "returns false if the limit has passed" do
				time = Time.now

				r = Runlimited::Base.new( :interval => 5 )

				Timecop.freeze( time ) do
					r.update
				end

				Timecop.freeze( time + 100 ) do 
					r.limited?.must_equal false
				end
			end

			it "returns true if the limit has not passed" do
				time = Time.now

				Timecop.freeze( time ) do
					r = Runlimited::Base.new( :interval => 5 )
					r.update
					r.limited?.must_equal true
				end
			end
		end

		describe "#limit" do
			it "takes a block returning an array" do
				limiter = Runlimited::Base.new

				result = limiter.limit do
					'successful attempt'
				end

				result.must_be_instance_of Array
			end


			it "should return an array of [true, <block return value>] if limit has passed" do
				limiter = Runlimited::Base.new

				result = limiter.limit do
					'successful attempt'
				end

				result.length.must_equal 2
				result[0].must_equal true
				result[1].must_equal 'successful attempt'
			end

			it "should return an array of [false] if the limit has not passed" do
				limiter = Runlimited::Base.new

				limiter.limit do
					'success attempt'
				end

				result = limiter.limit do
					'fail attempt'
				end

				result.length.must_equal 1
				result[0].must_equal false
			end
		end
  end
end
