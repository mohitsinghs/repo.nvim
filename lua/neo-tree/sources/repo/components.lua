local highlights = require("neo-tree.ui.highlights")
local common = require("neo-tree.sources.common.components")

local M = {
  internal = {
    repo_icon = "",
    github_icon = "",
    gitlab_icon = "",
    bitbucket_icon = "",
    azure_icon = "",
  },
}

M.icon = function(config, node, _)
  local icon = config.default or " "
  local highlight = config.highlight or highlights.FILE_ICON
  local extra = node.extra or {}
  if extra.kind == "folder" then
    highlight = highlights.DIRECTORY_ICON
    if node.loaded and not node:has_children() then
      icon = not node.empty_expanded and config.folder_empty or config.folder_empty_open
    elseif node:is_expanded() then
      icon = config.folder_open
    else
      icon = config.folder_closed
    end
  elseif extra.kind == "repo" then
    if extra.provider == "github" then
      icon = M.internal.github_icon
    elseif extra.provider == "gitlab" then
      icon = M.internal.gitlab_icon
    elseif extra.provider == "bitbucket" then
      icon = M.internal.bitbucket_icon
    elseif extra.provider == "azure" then
      icon = M.internal.azure_icon
    else
      icon = M.internal.repo_icon
    end
  end

  return {
    text = icon .. " ",
    highlight = highlight,
  }
end

return vim.tbl_deep_extend("force", common, M)
