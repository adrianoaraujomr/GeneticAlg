#!/usr/bin/ruby -w

require "./write_results.rb"
require "./selection_methods.rb"
require "./individual.rb"
require 'gruff'

class GeneticAlg
	@@generations = 50

	def initialize(pop,smethods)
		@population    = pop
		@selection     = smethods
	end

	def run()
		write_parameters(@population.return_params)

		for i in 0..@@generations do
			eval = @population.fitness($sonet)

			# Seleção
			seld = @selection.run(eval,0.625)
			puts seld.inspect
			# Cruzamento/Combinação
			aux = Set.new
			for j in 1..(seld.length - 1)
				ret = @population.people[seld[j - 1]].crossing(@population.people[seld[j]])
				if !ret.nil? 
					aux.merge ret
				end
			end
			aux = aux.to_a

			# Mutação
			for j in seld
				@population.people[j].mutation
			end

			# Update population			
			@population.update_population(aux,$sonet)

			eval = @population.fitness($sonet)
			# Write eval to file
			puts eval.inspect
			write_fitness(i,eval)

#			if i % 150 == 0
#				g = Gruff::Scatter.new
#				g.title = "Population #{i} : Best #{best}"
#				g.data('individuos', @population.pop_values(),@population.fitness())
#				g.write("./graphs/population#{i}.png")
#			end

#			n_ind = @population.pop_values().length
#			puts "Population #{i} : Best #{best} : Pop #{n_ind}"
		end
#		update_file()
	end
end

END {
	init_file()
	$sonet = SocialNetwork.new

	pop = SPopulation.new(5,$sonet.keys)
	sel = Tournament.new()
	gen = GeneticAlg.new(pop,sel)
	gen.run()
}
