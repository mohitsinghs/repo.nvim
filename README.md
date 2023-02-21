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

## Usage

`:Telescope repo` - Lists all available repositories.

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

## TODO

- [x] Telescope integration
- [x] Neotree integration
- [ ] Tests
