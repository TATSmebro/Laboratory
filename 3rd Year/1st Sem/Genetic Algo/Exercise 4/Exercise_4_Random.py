import random, math, time
from deap import algorithms, base, creator, tools

creator.create("FitnessMin", base.Fitness, weights=(-1.0,))
creator.create("Individual", list, fitness=creator.FitnessMin)

# Evalutaion function using the objective function
# (|x| + |y|) · (1 + |sin(|x| · π)| + |sin(|y| · π)|) 
def eval(individual):
    x = individual[0]
    y = individual[1]
    ret = (abs(x) + abs(y)) * (1 + abs(math.sin(abs(x) * math.pi)) + abs(math.sin(abs(y) * math.pi)))
    return (ret,)

# Evalutaion function using the objective function
# (|x| + |y|) · (1 + |sin(3 · |x| · π)| + |sin(3 · |y| · π)|) 
def eval2(individual):
    x = individual[0]
    y = individual[1]
    ret = (abs(x) + abs(y)) * (1 + abs(math.sin(3 * abs(x) * math.pi)) + abs(math.sin(3 * abs(y) * math.pi)))
    return (ret,)

# Custom initRepeat that takes in n as parameter for the function being called
def customInitRepeat(container, func, n):
    return container(func(n) for n in range(n))

# Returns an integer x, wherein -60 <= x <= 40 if its the first elements and -30 <= x <= 70 if it is the second element
def createAttribute(n):
    return random.randint(-60, 40) if n == 0 else random.randint(-30, 70)

toolbox = base.Toolbox()

IND_SIZE = 2 # x and y

toolbox.register("attr_bool", createAttribute)
toolbox.register("individual", customInitRepeat, creator.Individual, toolbox.attr_bool, IND_SIZE)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

toolbox.register("evaluate", eval)
toolbox.register("mate", tools.cxOnePoint)
toolbox.register("mutate", tools.mutUniformInt, low = [-60, -30], up = [30, 70], indpb=1)
toolbox.register("select", tools.selTournament, tournsize=2)

for i in range(10):
    popSize = 100
    pop = toolbox.population(n=popSize)
    result = algorithms.eaSimple(pop, toolbox, cxpb=0.5, mutpb=0.2, ngen=20, verbose=True)
    print(f'* Population size: {popSize} => Best points: ({tools.selBest(pop, k=1)[0][0]}, {tools.selBest(pop, k=1)[0][1]})') 
    print()

print(f'CPU RUNTIME: {time.process_time()}')