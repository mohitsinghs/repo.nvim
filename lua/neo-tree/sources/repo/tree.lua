local Job = require("plenary.job")
local renderer = require("neo-tree.ui.renderer")

local M = {}

local function create_repo(val)
  return {
    id = val.location,
    name = val.label,
    type = "directory",
    ext = "repo",
  }
end

local function create_folder(id, key, children)
  return {
    id = id,
    name = key,
    type = "directory",
    ext = "folder",
    children = children,
  }
end

local function populate(context, item)
  local result = {}
  for key, val in pairs(item) do
    if key == "_children" then
      for _, v in pairs(val) do
        table.insert(result, create_repo(v))
      end
    elseif type(key) == "number" then
      table.insert(result, create_repo(val))
    else
      local folder_id = os.time() .. key
      table.insert(context.folders, folder_id)
      table.insert(result, create_folder(folder_id, key, populate(context, val)))
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

  local context = {
    folders = {},
  }

  for key, item in pairs(decoded) do
    if key == "_children" then
      for _, v in pairs(item) do
        table.insert(root.children, create_repo(v))
      end
    else
      local folder_id = os.time() .. key
      table.insert(context.folders, folder_id)
      table.insert(root.children, create_folder(folder_id, key, populate(context, item)))
    end
  end

  state.default_expanded_nodes = {}
  for _, val in pairs(context.folders) do
    table.insert(state.default_expanded_nodes, val)
  end
  renderer.show_nodes({ root }, state)
  state.loading = false
end

return M
