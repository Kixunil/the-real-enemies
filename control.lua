local function tree_removed(event)
	local dummy = event.entity.surface.find_entity("the-real-enemies-target-dummy", event.entity.position)
	if dummy then
		dummy.destroy()
	end
end

local function put_dummies_at_trees(surface, trees)
	for i, tree in pairs(trees) do
		local dummy = {
			name = "the-real-enemies-target-dummy",
			position = tree.position,
			force = "enemy",
			raise_built = false,
			create_build_effect_smoke = false
		}
		local dummy_entity = surface.create_entity(dummy)
		dummy_entity.health = tree.health
	end
end

local function on_chunk_generated(event)
	local surface = event.surface
	local trees = event.surface.find_entities_filtered{type = "tree", area=event.area}
	put_dummies_at_trees(surface, trees)
end

local function on_dummy_died(event)
	local trees = event.entity.surface.find_entities_filtered{type = "tree", area = {event.entity.position, event.entity.position}}
	for i, tree in pairs(trees) do
		tree.die()
	end
end

local function on_tree_damaged(event)
	local dummy = event.entity.surface.find_entity("the-real-enemies-target-dummy", event.entity.position)
	if dummy then
		dummy.health = event.final_health
	end
end

local function on_dummy_damaged(event)
	local trees = event.entity.surface.find_entities_filtered{type = "tree", area = {event.entity.position, event.entity.position}}
	for i, tree in pairs(trees) do
		tree.health = event.final_health
	end
end

local function setup_events()
	script.on_event(defines.events.on_chunk_generated, on_chunk_generated)

	script.on_event(defines.events.on_entity_died, tree_removed, {{ filter = "type", type = "tree"}})
	script.on_event(defines.events.on_player_mined_entity, tree_removed, {{ filter = "type", type = "tree"}})
	script.on_event(defines.events.on_robot_mined_entity, tree_removed, {{ filter = "type", type = "tree"}})

	script.on_event(defines.events.on_entity_died, on_dummy_died, {{ filter = "name", name = "the-real-enemies-target-dummy"}})

	script.on_event(defines.events.on_entity_damaged, on_tree_damaged, {{ filter = "name", name = "tree"}})

	script.on_event(defines.events.on_entity_damaged, on_dummy_damaged, {{ filter = "name", name = "the-real-enemies-target-dummy"}})
end

script.on_event(defines.events.on_research_finished,
	function(event) 
		if event.research.name == "the-real-enemies-discover" then
			global["discover-researched"] = true
			local force = event.research.force
			for i, surface in pairs(game.surfaces) do
				local trees = surface.find_entities_filtered{type = "tree"}
				put_dummies_at_trees(surface, trees)
			end

			setup_events()
		end
	end
)

script.on_load(
	function() 
		if global["discover-researched"] then
			setup_events()
		end
	end
)
