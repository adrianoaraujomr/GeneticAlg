#!/usr/bin/ruby -w

require "./selection_methods.rb"
require "./individual.rb"
require 'gruff'

class GeneticAlg
	@@generations = 20000

	def initialize(pop,smethods)
		@population    = pop
		@selection     = smethods
	end

	def run()
		for i in 0..@@generations do
			puts @population.pop_values().inspect

#			eval = @population.fitness($sonet)
			# Seleção
#			seld = @selection.run(eval,0.625)

#			puts eval.inspect
#			puts seld.inspect

			# Cruzamento/Combinação
#			for j in 1..(seld.length - 1)
#				ret = @population.people[seld[j - 1]].crossing(@population.people[seld[j]])
#			end
#			puts @population.pop_values().inspect

			# Mutação
#			for j in seld
#				@population.people[j].mutation
#			end

#			puts @population.pop_values().inspect
			
#			best = @population.fitness().sort[0]

#			if i % 150 == 0
#				g = Gruff::Scatter.new
#				g.title = "Population #{i} : Best #{best}"
#				g.data('individuos', @population.pop_values(),@population.fitness())
#				g.write("./graphs/population#{i}.png")
#			end

#			n_ind = @population.pop_values().length
#			puts "Population #{i} : Best #{best} : Pop #{n_ind}"
			break
		end
	end
end

END {
	$sonet = SocialNetwork.new

	pop = SPopulation.new(5,$sonet.keys)
	sel = Tournament.new()
	gen = GeneticAlg.new(pop,sel)
	gen.run()
}
