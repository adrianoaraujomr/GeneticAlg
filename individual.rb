#!/usr/bin/ruby -w

require 'set'
require "./file_to_hash"
require "./selection_methods.rb"

#END{
#	$sonet = SocialNetwork.new
#	pop    = SPopulation.new(10,$sonet.keys)
#	puts "Fitness :"
#	for i in pop.people do
#		puts i.fitness($sonet).inspect
#	end
#}

class SocialNetwork
	@@graph = read_transform()

	def show_graph()
		return @@graph
	end

	def keys()
		return @@graph.keys
	end

	def neighbours(nodes)
		neigh = Set.new

		for v in nodes
			aux = Set.new @@graph[v] 
			neigh.merge aux
		end

		return neigh.length
	end
end

# Individual 02
#	array of nodes

class IndividualGraph
	@@prob_mutation = 0.2
	@@prob_crossing = 0.625
	@@a             = 5
	@@b             = 3
	attr_accessor :feature

	# Mudar feature de Array para Set
	def initialize(keys)
		@keys = keys
#		val = rand(keys.size) + 1  # Maybe try a lower value
		val = rand(@@a) + @@b
		@feature = keys.sample(val)
	end

	def prob_mutation()
		return @@prob_mutation
	end

	def prob_crossing()
		return @@prob_crossing
	end

	def range_val()
		return [@@a,@@b]
	end


	def fitness(graph)
		fit = Array.new()
		flw = graph.neighbours(@feature)
		fit.push(@feature.size,flw)
		
		return fit
	end

	# sortear entre (troca, remoção, adição de nos no vetor de individuo)
	def mutation()
		if rand() <= @@prob_mutation
			if @feature.length <= 1 
				idx = rand(2)
			else
				idx = rand(3)
			end

			case idx
			when 1 then
				loop do
					aux = @keys.sample
					if not @feature.include?(aux)
						@feature.push(aux)	
						break
					end
				end 
			when 2 then
					aux = rand(@feature.length)
					@feature.delete_at(aux)
			else
				loop do
					aux = @keys.sample
					if not @feature.include?(aux)
						@feature.push(aux)	
						break
					end
				end 
				if @feature.length > 1 
					aux = rand(@feature.length)
					@feature.delete_at(aux)
				end
			end
		end
	end

	# Ideia 1 : sortear um ponto em cada vetor e fazer a troca das partes do vetor de cada individuo
	# Ideia 2 : sortear algumas posições e fazer trocas (1 or more)
	def crossing(partner)
		if rand() <= @@prob_crossing
			if Set.new(@feature) == Set.new(partner.feature)
				return nil
			end
#			i = rand(@feature.length)
#			p11 = @feature[0,i]
#			p12 = @feature[i,@feature.length]

#			j = rand(partner.feature.length)
#			p21 = partner.feature[0,j]
#			p22 = partner.feature[j,@feature.length]

#			f1 = Set.new p11
#			f2 = Set.new p22
#			puts f1.inspect
#			puts f2.inspect

#			f1.merge p21
#			f2.merge p12
#			puts f1.inspect
#			puts f2.inspect

			# Run some test to see if duplicated values do not apper
#			f1 = f1.to_a
#			f2 = f2.to_a

#			ret = Array.new
#			ret.push(f1)
#			ret.push(f2)

#			return ret

#		------------------------------------------------------------------------------------------

			p1 = @feature
			p2 = partner.feature

			puts "Crossing "

			puts p1.inspect
			puts p2.inspect

			aux1 = @feature.sample
			while partner.feature.include? aux1 
				aux1 = @feature.sample
			end

			aux2 = partner.feature.sample
			while @feature.include? aux2
				aux2 = partner.feature.sample
			end

			partner.feature.push(aux1)
			@feature.push(aux2)

			@feature.delete(aux1)
			partner.feature.delete(aux2)

			puts @feature.inspect
			puts partner.feature.inspect

			f1xp1 = Domination(p1,@feature)
			f2xp2 = Domination(p2,partner.feature)

			if f1xp1 == 1
				@feature = p1
			end 

			if f2xp2 == 1
				partner.feature = p2
			end

			puts @feature.inspect
			puts partner.feature.inspect

			return nil

		end
			return nil
	end
end

class SPopulation
	attr_accessor :people

	def initialize(nro,keys)
		@people =  Array.new()

		for i in 1..nro do
			@people.push(IndividualGraph.new(keys))
		end
	end

	def return_params()
		pop_size = @people.length
		cro_prob = @people[0].prob_crossing
		mut_prob = @people[0].prob_mutation
		rnge_val = @people[0].range_val

		return [pop_size,cro_prob,mut_prob,rnge_val]
	end

	def update_population(children,graph)
#		puts children.inspect
		j = 0

		for i in 0..@people.length - 1
			if j == children.length
				break
			end

			child_fit = [children[j].size,graph.neighbours(children[j])]
			aux = Domination(child_fit,@people[i].fitness(graph))

			case aux
			when 1 then
#				puts "Change to children"
				@people[i].feature = children[j]
				j += 1
			when 0 then
				rnd = rand(2)
				if rnd == 1
#					puts "Change to children"
					@people[i].feature = children[j]
					j += 1
				end
			end

		end
	end

	def pop_values()
		@people.map {|x| x.feature}
	end

	def fitness(graph)
		@people.map {|x| x.fitness(graph)}
	end

end

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
