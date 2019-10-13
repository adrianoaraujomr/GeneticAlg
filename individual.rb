#!/usr/bin/ruby -w

# Individual 01
#	minimizar x² + 100x - 16

$limit = 100

class IndividualCube
	@@prob_mutation = 0.1
	@@prob_crossing = 0.8

	attr_accessor :value

	def initialize(value)
		@value = value 
	end

	def fitness()
		return (@value**2) + 100*@value - 16
	end

	def mutation()
		if rand() <= @@prob_mutation
			p = [true, false].sample
			if p 
				@value = @value - 1
			else 
				@value = @value + 1
			end
		end
	end

	def crossing(partner)
		if rand() <= @@prob_crossing
			aux = IndividualCube.new((@value + partner.value)/2)
			if aux.fitness() < self.fitness()
#				puts "Trade 1"
				@value = aux.value
			end
			if aux.fitness() < partner.fitness()
#				puts "Trade 2"
				partner.value = aux.value
			end
		end
	end
end

class Population
	attr_accessor :people

	def initialize(nro)
		@people =  Array.new()

		for i in 1..nro do
			value = (-1)*(rand $limit) - 1000#- value/2
			@people.push(IndividualCube.new(value))
		end
	end

	def pop_values()
		@people.map {|x| x.value}
	end

	def fitness()
		@people.map {|x| x.fitness}
	end
end
