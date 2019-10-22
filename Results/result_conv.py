#!/usr/bin/python3

import os
import matplotlib.pyplot as plt

fig_dir = "../pyplots/"

def plot_graphs(fn,nodes,flwrs):
	gen = range(0,len(nodes))

	fig = plt.figure()

	plt.subplot(2,1,1)
	plt.plot(gen,nodes)
	plt.title('Perfis')

	plt.subplot(2,1,2)
	plt.plot(gen,flwrs)
	plt.title('Followers')

	plt.tight_layout()

	fn = fn.split('.')[0]
	plt.savefig(fig_dir + fn + ".png")
	
	plt.close()


files = os.listdir(".")
for fn in files:

	if ".csv" in fn:
		nodes = []
		flwrs = []

		fd = open("./" + fn,"r")
		lines = fd.readlines()

		# Run trough the population generations
		for ln in lines[1:]:
			ln = ln.strip("\n")
			ln = ln.split(";")

			n_min = 81306
			f_max = 0

			# Fitness of the population in generation l[0]
			for l in ln[1:len(ln) - 1]:
				l = l.strip("]").strip("[")
				l = l.split(",")
				if(int(l[0]) < n_min):
					n_min = int(l[0])
				if(int(l[1].strip(" ")) > f_max):
					f_max = int(l[1].strip(" "))
			nodes.append(n_min)
			flwrs.append(f_max)

		print(len(nodes))
		print(len(flwrs))
		plot_graphs(fn,nodes,flwrs)
