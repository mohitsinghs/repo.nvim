local Job = require("plenary.job")
local renderer = require("neo-tree.ui.renderer")

local M = {}

local function populate(item)
  local result = {}
  for key, val in pairs(item) do
    if key == "_children" then
      for _, v in pairs(val) do
        table.insert(result, {
          id = v.location,
          name = v.label,
          type = "directory",
          ext = "repo",
        })
      end
    elseif type(key) == "number" then
      table.insert(result, {
        id = val.location,
        name = val.label,
        type = "directory",
        ext = "repo",
      })
    else
      table.insert(result, {
        id = key,
        name = key,
        type = "directory",
        ext = "folder",
        children = populate(val),
      })
    end
  end
  return result
end

M.find_repos = function(state)
  if state.loading then
    return
  end
  state.loading = true

  local root = {
    id = "repo",
    name = "Repositories",
    loaded = true,
    children = {},
  }

  local job = Job:new({
    command = "repo",
    args = { "cmp", "--tree" },
    cwd = vim.loop.cwd(),
  })

  job:sync()

  local result = job:result()
  local decoded = vim.json.decode(result[1]) or {}

  for key, item in pairs(decoded) do
    table.insert(root.children, {
      id = key,
      name = key,
      type = "directory",
      ext = "folder",
      children = populate(item),
    })
  end

  renderer.show_nodes({ root }, state)
  state.loading = false
end

return M
