local manager = require("neo-tree.sources.manager")
local repo = require("neo-tree.sources.repo.repo")

local M = { name = "repo" }

M.navigate = function(state)
  repo.find_repos(state)
end

M.refresh = function()
  manager.refresh(M.name)
end

M.setup = function() end

return M
