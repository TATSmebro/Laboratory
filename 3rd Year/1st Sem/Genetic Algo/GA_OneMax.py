import random
from deap import algorithms, base, creator, tools

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

IND_SIZE = 50
POP_SIZE = 100

toolbox = base.Toolbox()

def GAeval(individual):
    fitness = 0
    
    for bit in individual:
        fitness += bit
    
    return fitness,

#Genetic Algorithm Specifications
toolbox.register("bit", random.randint, 0, 1)
toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.bit, IND_SIZE)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

toolbox.register("mate", tools.cxOnePoint)
toolbox.register("mutate", tools.mutFlipBit, indpb=1./IND_SIZE) 
toolbox.register("select", tools.selTournament, tournsize=3)
toolbox.register("get_best", tools.selBest, k=1)

toolbox.register("evaluate", GAeval)

def main():

    pop = toolbox.population(n=POP_SIZE)
    result = algorithms.eaSimple(pop, toolbox, cxpb=0.7, mutpb=0.01, ngen=200, verbose=True)
    best = [str(i) for i in toolbox.get_best(pop)[0]]
    print("".join(best))
    print(toolbox.evaluate(toolbox.get_best(pop)[0]))


main()
    

