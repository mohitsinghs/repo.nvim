local actions = require("telescope.actions")
local actions_set = require("telescope.actions.set")
local actions_state = require("telescope.actions.state")
local config = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local finders = require("telescope.finders")
local from_entry = require("telescope.from_entry")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")
local Path = require("plenary.path")
local telescope = require("telescope")

local home_dir = vim.uv.os_homedir()

local function simplify_path(path)
  if path == Path.path.root() then
    return path
  end

  if home_dir and vim.startswith(path, home_dir) then
    return (Path:new("~") / Path:new(path):make_relative(home_dir)).filename
  end
  return path
end

local function path_maker()
  return function(line)
    return {
      value = line,
      ordinal = line,
      path = line,
      display = function(entry)
        local dir = simplify_path(entry.path)
        return entry_display.create({
          items = { {} },
        })({ dir })
      end,
    }
  end
end

local function find_repos(opts)
  local repo_command = (function()
    if opts.repo_command then
      if type(opts.repo_command) == "function" then
        return opts.repo_command(opts)
      end
      return opts.repo_command
    elseif vim.fn.executable("repo") == 1 then
      return { "repo" }
    end
  end)()

  if not repo_command then
    utils.notify("repo.find_repos", {
      msg = "You need to install repo binary",
      level = "ERROR",
    })
    return
  end

  local find_repos_args = { "cmp", "--full" }

  opts.entry_maker = utils.get_lazy_default(opts.entry_maker, path_maker, opts)

  table.insert(repo_command, find_repos_args)
  table.insert(repo_command, opts.search_dirs)
  repo_command = vim.iter(repo_command):flatten()

  pickers
    .new({
      prompt_title = "Repositories",
      finder = finders.new_oneshot_job(repo_command, opts),
      previewer = false,
      sorter = config.file_sorter(opts),
      layout_strategy = "center",
      layout_config = {
        width = 60,
      },
      attach_mappings = function(prompt_bufnr)
        actions_set.select:replace(function()
          actions.close(prompt_bufnr)
          local entry = actions_state.get_selected_entry()
          local dir = from_entry.path(entry)
          vim.schedule(function()
            vim.cmd("cd" .. dir)
          end)
        end)
        return true
      end,
    })
    :find()
end

return telescope.register_extension({
  exports = {
    repo = find_repos,
  },
})
