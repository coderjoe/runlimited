require 'spec_helper'

describe Somelimited do
  describe "Base" do
    before do
      @ratelimiter = Somelimited::Base.new
    end

    it "exposes a class" do
			Somelimited::Base.must_be_instance_of Class
    end

    it "accepts an interval argument exposed as #interval" do
      s = Somelimited::Base.new( 1 )
      s.must_respond_to :interval
      s.interval.must_equal 1
    end

    it "defaults #wait to 5 seconds" do
			Somelimited::Base.new.interval.must_equal 5
    end

    it "responds to #last_request" do
      @ratelimiter.must_respond_to :last_request
    end

    it "returns the time of the last request" do
      @ratelimiter.last_request.must_be_instance_of Time
    end

    it "updates the last request on #update" do
      @ratelimiter.must_respond_to :update
    end

    it "returns boolean from #limited?" do
      @ratelimiter.must_respond_to :limited?
      true.must_equal @ratelimiter.limited?.is_a?(TrueClass) || @ratelimiter.limited?.is_a?(FalseClass)
    end

    it "returns false from #limited? if the limit is passed" do
      Time.expects(:new).returns(Time.at(0))
      r = Somelimited::Base.new(5)

      Time.expects(:new).returns(Time.at(0)+100)
      r.limited?.must_equal false
    end

    it "returns true from #limited? if the limit has not passed" do
      Time.any_instance.stubs(:new).returns(Time.at(0))
      r = Somelimited::Base.new(5)
      r.limited?.must_equal true
    end
  end
end
