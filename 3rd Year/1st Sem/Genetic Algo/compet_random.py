import random, numpy
from deap import algorithms, base, creator, tools

#Initializations
creator.create("FitnessMin", base.Fitness, weights=(1.0,))
creator.create("Individual", list, fitness=creator.FitnessMin)

NUM_SPECIES = 2 #Number of Species
SPECIES_SIZE = 100 #Population of each species 
IND_SIZE = 50 #Individual Size or Bit size
TARGET_SIZE = 100
TARGET_TYPE = 2

toolbox = base.Toolbox()

def nicheSchematas(type, size):
    """Produce the desired schemata based on the type required, 2 for half
    length, 4 for quarter length and 8 for eight length.
    """
    rept = int(size/type)
    return ["#" * (i*rept) + "1" * rept + "#" * ((type-i-1)*rept) for i in range(type)]

def initTargetSet(schemata, size):
    """Initialize a target set with noisy string to match based on the
    schematas provided.
    """
    test_set = []
    for _ in range(size):
        test = list(random.randint(0, 1) for _ in range(len(schemata)))
        for i, x in enumerate(schemata):
            if x == "0":
                test[i] = 0
            elif x == "1":
                test[i] = 1
        test_set.append(test)
    return test_set

def matchStrength(x, y):
    """Compute the match strength for the individual *x* on the string *y*.
    """
    return sum(xi == yi for xi, yi in zip(x, y))

def matchSetStrength(match_set, target_set):
    """Compute the match strength of a set of strings on the target set of
    strings. The strength is the maximum of all match string on each target.
    """
    sum = 0.0
    for t in target_set:
        sum += max(matchStrength(m, t) for m in match_set)
    return sum / len(target_set),

def competitive_fitness(individuals, target_set):
    # Calculate OneMax scores for both individuals
    onemax_scores = [sum(ind) for ind in individuals]

    # Assign fitness based on competition
    fitness = 50 - onemax_scores[1]
    return fitness,

#Genetic Algorithm Specifications
toolbox.register("bit", random.randint, 0, 1)
toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.bit, IND_SIZE)
toolbox.register("species", tools.initRepeat, list, toolbox.individual, SPECIES_SIZE)
toolbox.register("target_set", initTargetSet)

toolbox.register("mate", tools.cxOnePoint)
toolbox.register("mutate", tools.mutFlipBit, indpb=1./IND_SIZE) 
toolbox.register("select", tools.selTournament, tournsize=3)
toolbox.register("get_best", tools.selBest, k=1)
toolbox.register("evaluate", competitive_fitness)

def competRandomPair(extended=True, verbose=True):
    target_set = []
    species = []

    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", numpy.mean)
    stats.register("std", numpy.std)
    stats.register("min", numpy.min)
    stats.register("max", numpy.max)

    logbook = tools.Logbook()
    logbook.header = "gen", "species", "evals", "std", "min", "avg", "max"

    ngen = 200
    g = 0

    schematas = nicheSchematas(TARGET_TYPE, IND_SIZE)
    for i in range(TARGET_TYPE):
        size = int(TARGET_SIZE/TARGET_TYPE)
        target_set.extend(toolbox.target_set(schematas[i], size))
        species.append(toolbox.species())

    # Init with a random representative for each species
    representatives = [random.choice(s) for s in species]

    while g < ngen:
        # Initialize a container for the next generation representatives
        next_repr = [None] * len(species)
        for i, s in enumerate(species):
            # Vary the species individuals
            s = algorithms.varAnd(s, toolbox, 0.7, 0.01)

            # Get the representatives excluding the current species
            r = representatives[:i] + representatives[i+1:]
            for ind in s:
                ind.fitness.values = toolbox.evaluate([ind] + r, target_set)

            record = stats.compile(s)
            logbook.record(gen=g, species=i, evals=len(s), **record)

            if verbose: 
                print(logbook.stream)

            # Select the individuals
            species[i] = [random.choice(s) for i in range(len(s))]  # Random selection
            next_repr[i] = random.choice(s)   # Random Selection

            g += 1
        representatives = next_repr

    if extended:
        for r in representatives:
            print("".join(str(x) for x in r))

competRandomPair()