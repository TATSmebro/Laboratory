import random
import time
import statistics
from deap import tools, base, creator, benchmarks

#Initializations
creator.create("FitnessMin", base.Fitness, weights=(-1.0,))
creator.create("Individual", list, fitness=creator.FitnessMin)

IND_SIZE = 2
POPULATION_SIZE = 50

toolbox = base.Toolbox()
toolbox.register("attribute", random.uniform, a=-2.00, b=2.00)
toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.attribute, n=IND_SIZE)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def evaluate(individual):
    return benchmarks.rosenbrock(individual)

#Genetic Algorithm Specifications
toolbox.register("mate", tools.cxOnePoint)
toolbox.register("mutate", tools.mutFlipBit, indpb=0.5)
toolbox.register("select", tools.selRoulette)
toolbox.register("evaluate", evaluate)

def main():
    pop = toolbox.population(n=POPULATION_SIZE)
    CXPB, MUTPB, NGEN = 0.7, 0.6, 50
    fitness_evals = POPULATION_SIZE

    # Evaluate the entire population
    fitnesses = map(toolbox.evaluate, pop)
    for ind, fit in zip(pop, fitnesses):
        ind.fitness.values = fit

    for g in range(NGEN):
        # Select the next generation individuals
        offspring = toolbox.select(pop, len(pop))
        # Clone the selected individuals
        offspring = list(map(toolbox.clone, offspring))

        # Apply crossover and mutation on the offspring
        for child1, child2 in zip(offspring[::2], offspring[1::2]):
            if random.random() < CXPB:
                toolbox.mate(child1, child2)
                del child1.fitness.values
                del child2.fitness.values

        for mutant in offspring:
            if random.random() < MUTPB:
                toolbox.mutate(mutant)
                del mutant.fitness.values

        # Evaluate the individuals with an invalid fitness
        invalid_ind = [ind for ind in offspring if not ind.fitness.valid]
        fitnesses = map(toolbox.evaluate, invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit

        # The population is entirely replaced by the offspring
        pop[:] = offspring
        fitness_evals += len(invalid_ind)

    return pop, fitness_evals

CPU_TIMES = []
FITNESSES = []
EVALUATIONS = []

for i in range(30):
    POPULATION, FITNESS_EVALS = main()
    MAX_FITNESS = max([i[0] for i in list(map(evaluate, POPULATION))])
    
    CPU_TIMES.append(time.process_time())
    FITNESSES.append(MAX_FITNESS)
    EVALUATIONS.append(FITNESS_EVALS)

print(f'{min(CPU_TIMES)}, {max(CPU_TIMES)}, {sum(CPU_TIMES)/len(CPU_TIMES)}, {statistics.pstdev(CPU_TIMES)}')
print(f'{min(FITNESSES)}, {max(FITNESSES)}, {sum(FITNESSES)/len(FITNESSES)}, {statistics.pstdev(FITNESSES)}')
print(f'{min(EVALUATIONS)}, {max(EVALUATIONS)}, {sum(EVALUATIONS)/len(EVALUATIONS)}, {statistics.pstdev(EVALUATIONS)}')