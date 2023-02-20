<h1 align='center'>repo.nvim</h1>
<p align="center">
  <b>Switch between repositories with ease</b><br/>
  <sub>Access your local repositories within neovim</a></sub>
</p>
<p align='center'>
  <a href="https://github.com/mohitsinghs/repo.nvim/actions/workflows/tests.yml">
    <img alt="Tests" src="https://img.shields.io/github/actions/workflow/status/mohitsinghs/repo.nvim/tests.yml?style=flat-square" />
  </a>
  <a href="https://github.com/mohitsinghs/repo.nvim/actions/workflows/linter.yml">
    <img alt="Linting" src="https://img.shields.io/github/actions/workflow/status/mohitsinghs/repo.nvim/liniter.yml?style=flat-square" />
  </a>
  <a href="https://github.com/mohitsinghs/repo/blob/main/LICENSE">
    <img alt="LICENSE" src="https://img.shields.io/github/license/mohitsinghs/repo?style=flat-square" />
  </a>
</p>

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
