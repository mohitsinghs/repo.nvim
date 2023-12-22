local cc = require("neo-tree.sources.common.commands")
local renderer = require("neo-tree.ui.renderer")
local command = require("neo-tree.command")

local M = { name = "repo" }

M.open = function(state)
  local tree = state.tree
  local success, node = pcall(tree.get_node, tree)
  if not (success and node) then
    return
  end
  print("open called", vim.inspect(node))
  local extra = node.extra or {}
  if extra.kind == "folder" then
    local updated = false
    if node:is_expanded() then
      updated = node:collapse()
    else
      updated = node:expand()
    end
    if updated then
      renderer.redraw(state)
    end
  elseif extra.kind == "repo" then
    local path = extra.location
    vim.cmd("cd" .. path)
    command.execute({ action = "focus", source = "filesystem" })
  end
end

cc._add_common_commands(M)

return M
