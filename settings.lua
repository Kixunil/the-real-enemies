local dev_mode = {
	type = "bool-setting",
	name = "the-real-enemies-dev-mode",
	hidden = true,
	default_value = false,
	forced_value = false,
	setting_type = "startup"
}

data:extend{dev_mode}
