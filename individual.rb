#!/usr/bin/ruby -w

require 'set'
require "./file_to_hash"

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
		puts nodes.inspect
		neigh = Set.new

#		puts "Nodes Followers :"
		for v in nodes
			aux = Set.new @@graph[v] 
			neigh.merge aux
		end
#		puts neigh.inspect
		puts neigh.length

		return neigh.length
	end
end

# Individual 02
#	array of nodes

class IndividualGraph
	@@prob_mutation = 1.1
	@@prob_crossing = 0.8
	attr_accessor :feature

	# Mudar feature de Array para Set
	def initialize(keys)
		@keys = keys
#		val = rand(keys.size) + 1  # Maybe try a lower value
		val = rand(5) + 3
		@feature = keys.sample(val)
	end

	def fitness(graph)
		fit = Array.new()
		flw = graph.neighbours(@feature)
		fit.push(@feature.size,flw)
		
		return fit
	end

	# sortear um ponto em cada vetor e fazer a troca das partes do vetor de cada individuo
	def crossing(partner)
		puts @feature.inspect
		puts partner.feature.inspect

		i = rand(@feature.length)
		p11 = @feature[0,i - 1]
		p12 = @feature[i,@feature.length]

		j = rand(partner.feature.length)
		p21 = partner.feature[0,j - 1]
		p22 = partner.feature[j,@feature.length]

		f1 = Set.new p11
		f2 = Set.new p22

		f1.merge p21
		f2.merge p12

		# Run some test to see if duplicated values do not apper
		f1 = f1.to_a
		f2 = f2.to_a

		ret = Array.new
		ret.push(f1)
		ret.push(f2)

		return ret
	end

	# sortear entre (troca, remoção, adição de nos no vetor de individuo)
	def mutation()
		if rand() <= @@prob_mutation
			idx = rand(3) + 1

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
				if @feature.length > 1 
					aux = rand(@feature.length)
					@feature.delete_at(aux)
				end
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

end

class SPopulation
	attr_accessor :people

	def initialize(nro,keys)
		@people =  Array.new()

		for i in 1..nro do
			@people.push(IndividualGraph.new(keys))
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
