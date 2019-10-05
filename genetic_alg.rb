#!/usr/bin/ruby -w

require "./selection_methods.rb"
require "./individual.rb"

class GeneticAlg
	def initialize(pop,smethods)
		# 1 - Create population
		@population    = pop
		@selection     = smethods
#		@gen_operators = GenOperators.new()
	end

	def run()
		while true
			eval = @population.fitness()
			seld = @selection.run(eval,0.5)
			puts seld
			# 4 - run crossing over
			# @gen_operators.coito(@population)
			# 5 - run mutation
			# @gen_operators.xmen(@population)
			# 6 - change population
			break
		end
	end
end

END {
	pop = Population.new(10)
	sel = Roulette.new()
	gen = GeneticAlg.new(pop,sel)
	gen.run()
}
