-- Copyright (c) 2015-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.

local Set = require 'pl.Set'

local babi = require 'babi'
local actions = require 'babi.actions'
local utilities = require 'babi.utilities'

local Deduction = torch.class('babi.Deduction', 'babi.Task', babi)

local animals = {
    {'mouse', 'mice'},
    {'sheep', 'sheep'},
    {'wolf', 'wolves'},
    {'cat', 'cats'},
    {'dog', 'dogs'},
    {'horse', 'horses'},
    {'cow', 'cows'},
    {'pig', 'pigs'},
    {'bird', 'birds'},
    {'fish', 'fish'},
    {'deer', 'deer'},
    {'moose', 'moose'},
    {'goose', 'geese'},
    {'ox', 'oxen'},
    {'fox', 'foxes'},
    {'lion', 'lions'},
    {'tiger', 'tigers'},
    {'bear', 'bears'},
    {'elephant', 'elephants'},
    {'rabbit', 'rabbits'},
    {'snake', 'snakes'},
    {'frog', 'frogs'},
    {'duck', 'ducks'},
    {'chicken', 'chickens'},
    {'bison', 'bison'},
    {'calf', 'calves'},
    {'louse', 'lice'},
    {'squirrel', 'squirrels'},
    {'zebra', 'zebras'},
    {'monkey', 'monkeys'},
    {'giraffe', 'giraffes'},
    {'kangaroo', 'kangaroos'},
    {'koala', 'koalas'},
    {'panda', 'pandas'},
    {'hippo', 'hippos'},
    {'rhino', 'rhinos'},
    {'crocodile', 'crocodiles'},
    {'alligator', 'alligators'},
    {'turtle', 'turtles'},
    {'whale', 'whales'},
    {'dolphin', 'dolphins'},
    {'shark', 'sharks'},
    {'octopus', 'octopuses'},
    {'crab', 'crabs'},
    {'lobster', 'lobsters'},
    {'shrimp', 'shrimp'},
    {'bee', 'bees'},
    {'ant', 'ants'},
    {'fly', 'flies'},
    {'spider', 'spiders'},
    {'bat', 'bats'},
    {'owl', 'owls'},
    {'eagle', 'eagles'},
    {'penguin', 'penguins'},
    {'goat', 'goats'},
    {'camel', 'camels'},
    {'llama', 'llamas'},
    {'hamster', 'hamsters'},
    {'guinea pig', 'guinea pigs'},
    {'ferret', 'ferrets'},
    {'badger', 'badgers'},
    {'beaver', 'beavers'},
    {'otter', 'otters'},
    {'seal', 'seals'},
    {'walrus', 'walruses'},
    {'cheetah', 'cheetahs'},
    {'leopard', 'leopards'},
    {'hyena', 'hyenas'},
    {'gorilla', 'gorillas'},
    {'chimpanzee', 'chimpanzees'},
    {'turkey', 'turkeys'},
    {'rat', 'rats'},
    {'butterfly', 'butterflies'},
    {'moth', 'moths'},
    {'worm', 'worms'},
    {'snail', 'snails'},
    {'jellyfish', 'jellyfish'},
    {'starfish', 'starfish'},
    {'hawk', 'hawks'},
    {'falcon', 'falcons'},
    {'parrot', 'parrots'},
    {'swan', 'swans'},
    {'crow', 'crows'},
    {'raven', 'ravens'},
    {'woodpecker', 'woodpeckers'},
    {'weasel', 'weasels'},
    {'skunk', 'skunks'},
    {'raccoon', 'raccoons'},
    {'chipmunk', 'chipmunks'},
    {'hedgehog', 'hedgehogs'},
    {'porcupine', 'porcupines'},
    {'elk', 'elk'},
    {'reindeer', 'reindeer'},
    {'buffalo', 'buffalo'},
    {'donkey', 'donkeys'},
    {'lizard', 'lizards'},
    {'gecko', 'geckos'},
    {'newt', 'newts'},
    {'toad', 'toads'},
    {'salmon', 'salmon'},
    {'trout', 'trout'},
    {'cod', 'cod'},
    {'squid', 'squid'},
    {'coyote', 'coyotes'},
    {'puma', 'pumas'},
    {'panther', 'panthers'},
    {'gnu', 'gnus'},
    {'gazelle', 'gazelles'},
    {'boar', 'boars'},
    {'peacock', 'peacocks'},
    {'pheasant', 'pheasants'},
    {'quail', 'quail'},
    {'sparrow', 'sparrows'},
    {'robin', 'robins'},
    {'dove', 'doves'},
    {'gull', 'gulls'},
    {'stork', 'storks'},
    {'crane', 'cranes'},
    {'heron', 'herons'},
    {'flamingo', 'flamingos'},
    {'emu', 'emus'},
    {'mole', 'moles'},
    {'shrew', 'shrews'},
    {'possum', 'possums'},
    {'armadillo', 'armadillos'},
    {'anteater', 'anteaters'},
    {'beetle', 'beetles'},
    {'caterpillar', 'caterpillars'},
    {'cockroach', 'cockroaches'},
    {'cricket', 'crickets'},
    {'dragonfly', 'dragonflies'},
    {'flea', 'fleas'},
    {'grasshopper', 'grasshoppers'},
    {'ladybug', 'ladybugs'},
    {'mosquito', 'mosquitoes'},
    {'scorpion', 'scorpions'},
    {'termite', 'termites'},
    {'tick', 'ticks'},
    {'wasp', 'wasps'}
}

local actors = {
    'Gertrude',
    'Winona',
    'Jessica',
    'Emily',
    'Tom',
    'Meryl',
    'Leonardo',
    'Scarlett',
    'Brad',
    'Angelina',
    'Denzel',
    'Viola',
    'Chris',
    'Jennifer',
    'Robert',
    'Emma',
    'Ryan',
    'Zendaya',
    'Olivia',
    'Liam',
    'Noah',
    'Amelia',
    'George',
    'Isla',
    'Oliver',
    'Ava',
    'Harry',
    'Sophia',
    'Charlie',
    'Mia',
    'William',
    'Isabella',
    'James',
    'Charlotte',
    'Henry',
    'Luna',
    'Theodore',
    'Aurora',
    'Jack',
    'Evelyn',
    'Alexander',
    'Harper',
    'Alfie',
    'Grace',
    'Arthur',
    'Chloe',
    'Leo',
    'Penelope',
    'Oscar',
    'Mila',
    'Archie',
    'Ella',
    'Freddie',
    'Abigail',
    'Thomas',
    'Ellie',
    'Jacob',
    'Aria',
    'Ethan',
    'Avery',
    'Michael',
    'Layla',
    'Daniel',
    'Sofia',
    'Matthew',
    'Victoria',
    'Joseph',
    'Madison',
    'Samuel',
    'Lily',
    'David',
    'Hannah',
    'Benjamin',
    'Nora',
    'Lucas',
    'Addison',
    'Andrew',
    'Stella',
    'Caleb',
    'Natalie',
    'Nathan',
    'Willow',
    'Isaac',
    'Zoey',
    'Elias',
    'Hazel',
    'Mason',
    'Violet',
    'Logan',
    'Riley',
    'Jackson',
    'Skylar',
    'Luke',
    'Savannah',
    'Jayden',
    'Audrey',
    'Levi',
    'Brooklyn',
    'Gabriel',
    'Bella',
    'Julian',
    'Claire',
    'Mateo',
    'Lucy',
    'Anthony',
    'Paisley',
    'Jaxon',
    'Everly',
    'Lincoln',
    'Anna'
}

-- Helper function to shuffle a table
local function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

function Deduction:new_world()
    local world = babi.World()

    -- Make a copy of the animals and shuffle
    local animal_copy = {table.unpack(animals)}
    shuffle(animal_copy)

    -- Pick first 4 animal pairs after shuffle
    for i = 1, 4 do
        local animal = animal_copy[i]
        world:create_entity(animal[1], {is_animal=true, plural=animal[2]})
    end

    -- Make a copy of the actors and shuffle
    local actor_copy = {table.unpack(actors)}
    shuffle(actor_copy)

    -- Pick first 4 actors after shuffle
    for i = 1, 4 do
        local actor = actor_copy[i]
        world:create_entity(actor, {is_actor=true, is_god=true})
    end

    return world
end

function Deduction:generate_story(world, knowledge, story)
    -- Find the actors and the locations in the world
    local actors = world:get_actors()
    local animals = world:get(function(entity) return entity.is_animal end)

    local assignments = torch.randperm(#actors):totable()
    local afraid_of = {}
    for i, _ in ipairs(animals) do
        repeat
            local j = math.random(#animals)
            afraid_of[i] = j
        until j ~= i
    end

    for i, j in ipairs(assignments) do
        story[i] = babi.Clause(world, true, world:god(), actions.set, actors[i],
                         'is', animals[j])
    end
    for i, j in ipairs(afraid_of) do
        story[i + #actors] = babi.Clause(world, true, world:god(), actions.set,
                                    animals[i], 'has_fear', animals[j])
    end
    for i = 1, #actors do
        story[i + 2 * #actors] = babi.Question(
            'eval',
            babi.Clause(world, true, world:god(), actions.set,
                   actors[i], 'has_fear', animals[afraid_of[assignments[i]]]),
            Set{story[i], story[assignments[i] + #actors]}
        )
    end
    local shuffled_story =
        utilities.choice(story:slice(1, 2 * #actors), 2 * #actors)
    shuffled_story:extend(
        utilities.choice(story:slice(2 * #actors + 1), #actors)
    )

    return shuffled_story, knowledge
end

return Deduction
