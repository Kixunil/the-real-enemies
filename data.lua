local technology = {
	type = "technology",
	name = "the-real-enemies-discover",
	icon = "__the_real_enemies__/graphics/research.png",
	icon_size = 256,
	unit = {
		count = 100,
		ingredients = {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1}
		},
		time = 60
	},
	prerequisites = {"military", "logistic-science-pack", "automation"},
	effects = {
		{
			type = "nothing"
		}
	}
}

if settings.startup["the-real-enemies-dev-mode"].value then
	technology.unit.count = 1
	technology.unit.time = 1
end

--log(serpent.block(data.raw))
local target_dummy = util.table.deepcopy(data.raw["simple-entity-with-force"]["simple-entity-with-force"])
target_dummy.name = "the-real-enemies-target-dummy"
target_dummy.flags = {"not-rotatable", "placeable-off-grid", "not-blueprintable", "not-deconstructable", "hidden", "not-flammable", "no-automated-item-removal", "no-automated-item-insertion", "not-upgradable", "not-in-kill-statistics", "not-selectable-in-game"}
target_dummy.minable = nil
target_dummy.selectable_in_game = false
target_dummy.collision_mask = {}
target_dummy.collision_box = {{0, 0}, {0, 0}}
target_dummy.selection_box = nil
target_dummy.is_military_target = true
target_dummy.max_health = 50
target_dummy.create_ghost_on_death = false
target_dummy.corpse = nil
target_dummy.pictures = nil
target_dummy.picture = {
	filename = "__the_real_enemies__/graphics/empty.png",
	priority = "extra-high",
	width = 1,
	height = 1,
	shift = {0, 0}
}

data:extend{technology, target_dummy}
