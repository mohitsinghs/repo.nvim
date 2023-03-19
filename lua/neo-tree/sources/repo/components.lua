local highlights = require("neo-tree.ui.highlights")
local common = require("neo-tree.sources.common.components")

local M = {
  internal = {
    repo_icon = "",
  },
}

M.icon = function(config, node, _)
  local icon = config.default or " "
  local highlight = config.highlight or highlights.FILE_ICON
  if node.ext == "folder" then
    highlight = highlights.DIRECTORY_ICON
    if node.loaded and not node:has_children() then
      icon = not node.empty_expanded and config.folder_empty or config.folder_empty_open
    elseif node:is_expanded() then
      icon = config.folder_open
    else
      icon = config.folder_closed
    end
  elseif node.ext == "repo" then
    icon = M.internal.repo_icon
  end

  return {
    text = icon .. " ",
    highlight = highlight,
  }
end

return vim.tbl_deep_extend("force", common, M)
