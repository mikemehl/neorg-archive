---@meta

---@class (exact) NeorgEvent
---@field broadcast boolean
---@field content table
---@field cursor_position { line: integer, column: integer }
---@field filehead string
---@field filename string
---@field line_content string
---@field mode string
---@field referrer string
---@field split_type string[]
---@field type string
---@field window integer

---@class NeorgSetupTable
---@field success boolean
---@field requires string[]
---@field replaces string
---@field replace_merge boolean

---@class NeorgModulePublic
---@field version string

---@class NeorgModuleConfig
---@field private table
---@field public table
---@field custom table

---@class NeorgModuleEvents
---@field subscribed table
---@field defined table

---@class NeorgModule
---@field setup fun(): NeorgSetupTable
---@field load fun()
---@field on_event fun(NeorgEvent)
---@field neorg_post_load fun()
---@field name string
---@field path string
---@field private table
---@field public NeorgModulePublic
---@field config NeorgModuleConfig
---@field events NeorgModuleEvents
---@field required table
---@field examples table
---@field imported table
