local KaelFrames = LibStub("AceAddon-3.0"):GetAddon("KaelFrames")
local LSM = KaelFrames.LSM

local defaults = {
	profile = {
		units = {
			['**'] = {
				enabled = true,
				enablemouse = true,
				framestyle = "default",
				scale = 1,
				strata = "MEDIUM",
				level = 1,
				fitwidth = false,
				fitheight = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					anchorframe = "parent",
					offsets = {
						vertical = 0,
						horizontal = 0,
						left = 0,
						right = 0,
						top = 0,
						bottom = 0,
					},
					anchors = {
						top = "parent",
						bottom = "parent",
						left = "parent",
						right = "parent",
					},
				},
			},
			player = {
			},
			target = {
			},
		},
		headers = {
		['**'] = {
				enabled = true,
				enablemouse = true,
				framestyle = "default",
				scale = 1,
				strata = "MEDIUM",
				level = 1,
				fitwidth = false,
				fitheight = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					anchorframe = "parent",
					offsets = {
						vertical = 0,
						horizontal = 0,
						left = 0,
						right = 0,
						top = 0,
						bottom = 0,
					},
					anchors = {
						top = "parent",
						bottom = "parent",
						left = "parent",
						right = "parent",
					},
				},
			},
			raid = {
			},
		},
		framestyles = {
			['**'] = {
				width = 200,
				height = 50,
				backdrop = {
					style = {
						enablebackdrop = true,
						enableborder = true,
						bginset = 0,
						borderinset = 0,
						bgcolor = {1, 1, 1, 1},
						bordercolor = {1, 1, 1, 1},
					},
					table = {
						bgFile = LSM:Fetch("background", "Solid"),
						edgeFile = LSM:Fetch("border", "Blizzard Tooltip"),
						tile = false,
						tileSize = 16,
						edgeSize = 16,
						insets = {
							left = 0,
							right = 0,
							top = 0,
							bottom = 0,
						},
					},
				},
				modules = {
					['**'] = {
						enabled = false,
						backdrop = {
							style = {
								enablebackdrop = true,
								enableborder = true,
								bginset = 0,
								borderinset = 0,
								bgcolor = {1, 1, 1, 1},
								bordercolor = {1, 1, 1, 1},
							},
							table = {
								bgFile = LSM:Fetch("background", "Solid"),
								edgeFile = LSM:Fetch("border", "Blizzard Tooltip"),
								tile = false,
								tileSize = 16,
								edgeSize = 16,
								insets = {
									left = 0,
									right = 0,
									top = 0,
									bottom = 0,
								},
							},
						},
						position = {
							anchorfrom = "CENTER",
							anchorto = "CENTER",
							anchorframe = "parent",
							offsets = {
								vertical = 0,
								horizontal = 0,
								left = 0,
								right = 0,
								top = 0,
								bottom = 0,
							},
							anchors = {
								top = "parent",
								bottom = "parent",
								left = "parent",
								right = "parent",
							},
						},
					},
				},
			},
			default = {
			},
		},
	},
}

KaelFrames.defaults = defaults