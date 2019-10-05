#!/usr/bin/ruby -w

# Individual 01
#	minimizar -x² + 5x - 16

$limit = 100

class IndividualCube
	@@prob_mutation = 0.2
	@@prob_crossing = 0.8

	attr_accessor :value

	def initialize(value)
		@value = (rand value ) - value/2
	end

	def fitness()
		return (-1)*(@value**2) + 5*@value - 16
	end

	def mutation()
		if rand() <= @@prob_mutation
			@value = @value - 1
		end
	end

	def crossing(partner)
		if rand() <= @@prob_crossing
			@value = (@value + partner.value)/2
		end
	end
end

class Population
	attr_accessor :people

	def initialize(nro)
		@people =  Array.new()

		for i in 1..nro do
			@people.push(IndividualCube.new($limit))
		end
	end

	def fitness()
		@people.map {|x| x.fitness}
	end
end
