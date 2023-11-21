local ts_utils = require("nvim-treesitter.ts_utils")
local neorg = require("neorg.core")
local modules = neorg.modules
local dirman = modules.dirman

---@class NeorgModule
local M = modules.create("external.archive")

M.name = "external.archive"
M.path = "modules.external.archive"
M.config.public = {
	file = "archive.org",
}

local neorg_setup = {
	success = true,
	requires = {
		"core.neorgcmd",
		"core.keybinds",
		"core.dirman",
		"core.dirman.utils",
	},
	replaces = nil,
	replace_merge = false,
}

M.private.commands = {}
M.private.commands.open = { args = 0 }
M.private.commands.add = { args = 0, condition = "norg" }

M.events.subscribed = {
	["core.neogcmd"] = {
		["external.archive.open"] = true,
		["external.archive.add"] = true,
	},
}

function M.setup()
	return neorg_setup
end

function M.load()
	M.required["core.neorgcmd"].add_commands_from_table(M.private.commands)
end

---@param event NeorgEvent
function M.on_event(event)
	local type = event.split_type[2]
	if type == "core.neorgcmd.events.external.archive.open" then
		M.private.open(event)
	elseif type == "core.neorgcmd.events.external.archive.add" then
		M.private.add(event)
	end
end

---Open the archive file in the current buffer.
function M.private.open(_)
	local archive_file = "$/" .. M.config.public.file
	archive_file = dirman.resolve(archive_file)
	local open_buffers = nvim_list_bufs()
	for _, buffer in ipairs(open_buffers) do
		local buffer_name = nvim_buf_get_name(buffer)
		if buffer_name == archive_file then
			nvim_set_current_buf(buffer)
			return
		end
	end
	local new_buf = nvim_create_buf(true, false)
	nvim_buf_set_name(new_buf, archive_file)
	nvim_win_set_buf(0, new_buf)
end

---@param event NeorgEvent
function M.private.add(event)
	return event
end

return M
