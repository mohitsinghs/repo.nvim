<h1 align='center'>repo.nvim</h1>
<p align="center">
  <b>Switch between repositories with ease</b><br/>
  <sub>Access your local repositories within neovim</a></sub>
</p>
<p align='center'>
  <a href="https://github.com/mohitsinghs/repo.nvim/actions/workflows/tests.yml">
    <img alt="Tests" src="https://img.shields.io/github/actions/workflow/status/mohitsinghs/repo.nvim/tests.yml?style=flat-square" />
  </a>
  <a href="https://github.com/mohitsinghs/repo/blob/main/LICENSE">
    <img alt="LICENSE" src="https://img.shields.io/github/license/mohitsinghs/repo?style=flat-square" />
  </a>
</p>

## Installations

This extension depends on [repo](https://github.com/mohitsinghs/repo). You can install relevant binary for your platform.

### With Telescope

It provides a list of repositories to switch between.

```lua
-- lazy.nvim
{
 'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mohitsinghs/repo.nvim',
  },
  config = function()
    -- telescope configs
    require'telescope'.load_extension'repo'
    -- other telescope configs
  end,
}
```

### With Neotree

It provides a tree of repositories to switch between.

```lua
 {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    'mohitsinghs/repo.nvim',
  },
 config = function()
   require('neotree').setup({
     -- neotree config
     sources = {
        -- other sources
       "repo",
     },
     -- other neotree configs
   })
 end
}
```

## Usage

- `:Telescope repo` - Lists all available repositories in telescope.
- `:Neotree focus repo` - focus on tree of repositories in neo-tree sidebar

## Development

### Run tests

Running tests requires [plenary.nvim][plenary] to be checked out in the parent directory of _this_ repository.
You can then run:

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"
```

Or if you want to run a single test file:

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/path_to_file.lua {minimal_init = 'tests/minimal.vim'}"
```

[plenary]: https://github.com/nvim-lua/plenary.nvim
