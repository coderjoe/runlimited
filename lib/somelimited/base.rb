module Somelimited

	# This class is a base class from which all implemented limiters should inherit
	# It is composed of a series of basic operations from which other limiters can be implemented
	# using their own storage mechanisms but behave the same
	
	# This class is the generic base class
	# The most important two methods are #last_request and #update which should be implemented
	# by any sublcassses
	class Base
		# The wait interval reader
		attr_reader :interval
		attr_reader :last_request

		# Set the wait interval in seconds
		def initialize(interval = 5)
			@interval = interval
			@last_request = Time.at(0)
		end

		# Return true if we should be limited, false otherwise
		def limited?
			(Time.new - last_request) < interval
		end

		# Run a block of code if and only if the limit is not currently hit
		def limit
			result = [ !limited? ]
			if block_given? && !limited?
				update
				result << yield
			end
			result
		end

		# Base update method. This hsould be overridden by implementing classes
		def update
			@last_request = Time.new
		end

	end
end
