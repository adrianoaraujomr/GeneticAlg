#!/usr/bin/ruby -w

require "./selection_methods.rb"
require "./individual.rb"

class GeneticAlg
	@@generations = 20

	def initialize(pop,smethods)
		@population    = pop
		@selection     = smethods
	end

	def run()
		for i in 0..@@generations
			eval = @population.fitness()
			# Seleção
			seld = @selection.run(eval,0.625)
			# Cruzamento/Combinação
			for i in 1..(seld.length - 1)
				@population.people[seld[i - 1]].crossing(@population.people[seld[i]])
			end
			# Mutação
			for i in seld
				@population.people[i].mutation
			end
			break
		end
	end
end

END {
	pop = Population.new(100)
	sel = Roulette.new()
	gen = GeneticAlg.new(pop,sel)
	gen.run()

}
