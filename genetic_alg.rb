#!/usr/bin/ruby -w

require "./selection_methods.rb"
#require "./gen_operators.rb"

class GeneticAlg
	def initialize(pop,smethods)
		# 1 - Create population
		@population    = pop
		@selection     = smethods
		@gen_operators = GenOperators.new()
	end

	def run()
		while true
			# 2 - evaluate individuals
			# 3 - run selection method
			# 4 - run crossing over
			# @gen_operators.coito(@population)
			# 5 - run mutation
			# @gen_operators.xmen(@population)
			# 6 - change population
		end
	end
end

END {
	fit = Array.new

	for i in 1..100 do
		fit.push(rand())
	end
	
	roulAlg = URandom.new(fit,0.8)
	roulAlg.run()
}
