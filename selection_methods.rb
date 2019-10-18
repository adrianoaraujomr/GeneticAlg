#!/usr/bin/ruby -w

# Cada um dos algoritmos:
#	Recebe vetor de fitness
#	Retorna index dos selecionados

class URandom
	def run(pop,sr)
		@population     = pop
		@selection_rate = sr 

		n_sorteios = @selection_rate*@population.length
		n_sorteios = n_sorteios.round

		selected = Array.new

		for i in 1..n_sorteios do
			aux = rand @population.length
			selected.push(aux)
		end

		return selected
	end
end


class Roulette
	# Probably will need changes, or changes in fitness will be necessary
	def probabilities()
		min = @population.sort.pop
		@population = @population.map{|x| (x - min)}
		sum = @population.inject(0){|sum,x| sum + x.abs}

		probs = Array.new
		aux   = 0
		for i in @population do
			aux += i.abs.fdiv(sum)
			probs.push(1 - aux)
		end

		return probs.reverse
	end

	def run(pop,sr)
		@population     = pop
		@selection_rate = sr

		n_sorteios = @selection_rate*@population.length
		n_sorteios = n_sorteios.round

		probs = self.probabilities()
		selected = Array.new
		for i in 1..n_sorteios do
			aux = rand()
			sl  = probs.rindex{|x| x < aux} #maybe this will need to change/ will return the last to satisfies the condition
			selected.push(sl)
		end

		return selected
	end
end

# Selecionar
class Tournament
	def initialize(pop,sr)
		@population     = pop
		@selection_rate = sr 
	end

end

