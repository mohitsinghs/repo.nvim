local cc = require("neo-tree.sources.common.commands")
local renderer = require("neo-tree.ui.renderer")

local M = { name = "repo" }

M.open = function(state)
  local tree = state.tree
  local success, node = pcall(tree.get_node, tree)
  if not (success and node) then
    return
  end
  if node.ext == "folder" then
    local updated = false
    if node:is_expanded() then
      updated = node:collapse()
    else
      updated = node:expand()
    end
    if updated then
      renderer.redraw(state)
    end
  else
    local path = node.id
    vim.cmd("cd" .. path)
    renderer.redraw(state)
  end
end

cc._add_common_commands(M)

return M
