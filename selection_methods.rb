#!/usr/bin/ruby -w

# Cada um dos algoritmos:
#	Recebe vetor de fitness
#	Retorna index dos selecionados

class URandom
	@population     = nil
	@selection_rate = 0.6

	def initialize(pop,sr)
		@population     = pop
		@selection_rate = sr 
	end

	def run()
		n_sorteios = @selection_rate*@population.length
		n_sorteios = n_sorteios.round

		selected = Array.new

		for i in 1..n_sorteios do
			aux = rand 100
			selected.push(aux)
		end

		return selected
	end
end


class Roulette
	@population     = nil
	@selection_rate = 0.6

	def initialize(pop,sr)
		@population     = pop
		@selection_rate = sr 
	end

	def probabilities()
		sum = @population.inject(0){|sum,x| sum + x }

		probs = Array.new
		aux   = 0
		for i in @population do
			aux += i/sum
			probs.push(aux)
		end

		return probs.reverse
	end

	def run()
		n_sorteios = @selection_rate*@population.length
		n_sorteios = n_sorteios.round

		probs = self.probabilities()

		selected = Array.new

		for i in 1..n_sorteios do
			aux = rand()
			sl  = probs.rindex{|x| x >= aux} #maybe this will need to change
			selected.push(sl)
		end

		return selected
	end
end

=begin
class Tournament
	def initialize(pop,sr)
		@population     = pop
		@selection_rate = sr 
	end

end
=end
