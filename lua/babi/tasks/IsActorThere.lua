-- Copyright (c) 2015-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.

local tablex = require 'pl.tablex'

local babi = require 'babi'
local actions = require 'babi.actions'

local IsActorThere = torch.class('babi.IsActorThere', 'babi.Task', babi)

function IsActorThere:new_world(world_strings)
    local world = babi.World()
    world:load_from_strings(world_strings)
    return world
end

function IsActorThere:generate_story(world, knowledge, story)
    -- NOTE Largely copy-paste of WhereIsActor
    -- Find the actors and the locations in the world
    local actors = world:get_actors()
    local locations = world:get_locations()

    -- Our story will be 2 statements, 1 question, 5 times
    for i = 1, 15 do
        if i % 3 ~= 0 then
            -- Find a random action
            local clause = babi.Clause.sample_valid(world, {true}, actors,
                {actions.teleport}, locations)
            clause:perform()
            story[i] = clause
            knowledge:update(clause)
        else
            -- Find the actors of which we know the location
            local known_actors = tablex.filter(
                knowledge:current():find('is_in'),
                function(entity) return entity.is_actor end
            )
            local affirmative = ({true, false})[math.random(2)]

            -- Pick a random one and ask where he/she is
            local random_actor = known_actors[math.random(#known_actors)]
            local location, support =
                knowledge:current()[random_actor]:get_value('is_in', true)
            if not affirmative then
                local options =
                    world:get_locations():clone():remove_value(location)
                location = options[math.random(#options)]
            end
            story[i] = babi.Question(
                'yes_no',
                babi.Clause(world, affirmative, world:god(), actions.set,
                       random_actor, 'is_in', location),
                support
            )
        end
    end
    return story, knowledge
end

return IsActorThere
