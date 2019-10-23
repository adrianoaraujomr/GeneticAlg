#!/usr/bin/ruby -w

require 'gruff'

save_dir = "./res_graphs/results_"

dir    = "./res_graphs"
fn     = "./results_"
format = ".csv"

for i in 1..12
	f_name =  fn + i.to_s + format
	fd     = File.new(f_name, "r")
	j = 0
	fd.each_line do |line|
		if (j - 1) % 150 == 0 and j != 0
			line = line.delete("\n")

			aux = line.split(";")
			aux.delete_at(0)
			aux = aux.to_a

			
			nds = Array.new
			flw = Array.new
			for x in aux
				vals = x.split(",")			

				nds.push(vals[0].delete("[").to_i)
				flw.push(vals[1].delete("}").to_i)
			end
			g = Gruff::Scatter.new
			g.title = "Population #{j}"
			g.data('individuos',nds,flw)
			g.write(save_dir + i.to_s + "/population#{j}.png")
		end
		j += 1
	end
end
