local status, db = pcall(require, "dashboard")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 dashboard", "error")
	return
end
db.session_directory = vim.fn.stdpath("data") .. "/vimSession"
local sharePath = require("commConf").sharePath
local luaPath = sharePath .. "/xray23/lua"
-- Example: Close NvimTree buffer before auto-saving the current session
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("User", {
-- 	pattern = "DBSessionSavePre",
-- 	callback = function()
-- 		pcall(vim.cmd, "NvimTreeClose")
-- 	end,
-- })
db.session_auto_save_on_exit = false
db.custom_footer = {
	-- "",
	"千里之行，始于足下                     ",
	"万事开头难                             ",
	-- "https://xray23.ltd                     ",
	-- "https://github.com/HUAHUA              ",
}
db.custom_center = {
	{
		icon = "🗓️  ",
		desc = "Projects                            ",
		action = "Telescope projects",
	},
	{
		-- icon = "📎  ",
		icon = "📝  ",
		desc = "Work Space                          ",
		-- action = "exe 'normal melloworld'",
		action = "Telescope xray23 list",
	},
	{
		-- icon = "📎  ",
		icon = "📺  ",
		desc = "Recently files                      ",
		action = "Telescope oldfiles",
	},
	{
		icon = "🔍️  ",
		desc = "Find file                           ",
		action = "Telescope find_files",
	},
	{
		icon = "📄  ",
		desc = "New file                           ",
		--  NOTE: enew is vim command to create new file
		action = "enew", -- enew
	},
	{
		-- icon = "📑  ",
		icon = "🕹️  ",
		desc = "Edit keybindings                    ",
		action = "edit" .. luaPath .. "/keybindingAlias.lua",
	},
	{
		icon = "📻  ",
		desc = "Edit Projects                       ",
		action = "edit" .. sharePath .. "/othersss/project_nvim/project_history",
	},
	-- {
	--   icon = "  ",
	--   desc = "Edit .bashrc                        ",
	--   action = "edit ~/.bashrc",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Change colorscheme                  ",
	--   action = "ChangeColorScheme",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Edit init.lua                       ",
	--   action = "edit ~/.config/nvim/init.lua",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Find file                           ",
	--   action = "Telescope find_files",
	-- },
	-- {
	--   icon = "  ",
	--   desc = "Find text                           ",
	--   action = "Telescopecope live_grep",
	-- },
}

db.custom_header = {
	[[]],
	[[]],
	[[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
	[[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
	[[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
	[[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
	[[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
	[[]],
	[[]],
}
-- db.custom_header = {
-- 	[[]],
-- 	[[]],
-- 	[[██╗░░██╗██╗░░░██╗░█████╗░██╗░░██╗██╗░░░██╗░█████╗░]],
-- 	[[██║░░██║██║░░░██║██╔══██╗██║░░██║██║░░░██║██╔══██╗]],
-- 	[[███████║██║░░░██║███████║███████║██║░░░██║███████║]],
-- 	[[██╔══██║██║░░░██║██╔══██║██╔══██║██║░░░██║██╔══██║]],
-- 	[[██║░░██║╚██████╔╝██║░░██║██║░░██║╚██████╔╝██║░░██║]],
-- 	[[╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝]],
-- 	[[]],
-- 	[[]],
-- }
-- db.custom_header = {
-- 	"",
-- 	"",
-- 	"",
-- 	"",
-- 	"",
-- 	"",
-- 	[[ ███▄    █     ▒█████      ██▓    ▄████▄     ▓█████   ]],
-- 	[[ ██ ▀█   █    ▒██▒  ██▒   ▓██▒   ▒██▀ ▀█     ▓█   ▀   ]],
-- 	[[▓██  ▀█ ██▒   ▒██░  ██▒   ▒██▒   ▒▓█    ▄    ▒███     ]],
-- 	[[▓██▒  ▐▌██▒   ▒██   ██░   ░██░   ▒▓▓▄ ▄██▒   ▒▓█  ▄   ]],
-- 	[[▒██░   ▓██░   ░ ████▓▒░   ░██░   ▒ ▓███▀ ░   ░▒████▒  ]],
-- 	[[░ ▒░   ▒ ▒    ░ ▒░▒░▒░    ░▓     ░ ░▒ ▒  ░   ░░ ▒░ ░  ]],
-- 	[[░ ░░   ░ ▒░     ░ ▒ ▒░     ▒ ░     ░  ▒       ░ ░  ░  ]],
-- 	[[   ░   ░ ░    ░ ░ ░ ▒      ▒ ░   ░              ░     ]],
-- 	[[         ░        ░ ░      ░     ░ ░            ░  ░  ]],
-- 	[[                                 ░                    ]],
-- }
-- 👻 🎵 🔔 🤖 🚑 ☕ 💦 ☔
-- see more: https://fsymbols.com/
-- https://fsymbols.com/text-art/twitter/
-- db.custom_header = {
-- 	[[]],
-- 	[[▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒]],
-- 	[[▒▒▄▄▄▒▒▒█▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▄▄▄▒▒▒█▒▒▒▒▄▒▒▒▒▒▒▒▒]],
-- 	[[▒█▀█▀█▒█▀█▒▒█▀█▒▄███▄▒▒█▀█▀█▒█▀█▒▒█▀█▒▄███▄▒]],
-- 	[[░█▀█▀█░█▀██░█▀█░█▄█▄█░░█▀█▀█░█▀██░█▀█░█▄█▄█░]],
-- 	[[░█▀█▀█░█▀████▀█░█▄█▄█░░█▀█▀█░█▀████▀█░█▄█▄█░]],
-- 	[[████████▀█████████████████████▀█████████████]],
-- 	[[]],
-- }
local shortcutgroup = "Normal"

local function themeSelect(theme)
	if theme == "doom" then
		db.setup({
			theme = "doom",
			config = {
				header = db.custom_header, -- ascii text in there
				center = db.custom_center,
				footer = db.custom_footer,
			},
		})
		return "doom"
	elseif theme == "hyper" then
		db.setup({
			theme = "hyper",
			config = {
				header = db.custom_header,
				shortcut = {
					{
						desc = "☕ Update",
						group = shortcutgroup,
						action = "PackerUpdate",
						key = "u",
					},
					{
						desc = "📑 Files",
						group = shortcutgroup,
						action = "Telescope oldfiles",
						key = "f",
					},
					{
						desc = "📺 Projects",
						group = shortcutgroup,
						action = "Telescope projects",
						key = "p",
					},
					{
						desc = "📻 Work Space",
						group = shortcutgroup,
						action = "Telescope xray23 list",
						key = "s",
					},
				},
				project = { limit = 2, icon = "🎵" },
				mru = { limit = 4, icon = "🕹️" },
				footer = {
					"",
					"",
					"千里之行，始于足下                     ",
					-- "https://xray23.ltd                     ",
					"https://github.com/HUAHUA              ",
				},
			},
		})
		return "hyper"
	else
		return
	end
end

themeSelect("doom")
