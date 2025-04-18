# TODO

- [ ] Change ~ and \` in oryx config
- [ ] Fix cpp snippets, they're not working
- [ ] Add templater/quickAdd for adding new headings
- [ ] Fix query for dataviewJS within a project
- [ ] Add better dataviewJS for command and code queries
  - [ ] Sort by tag group and tag subgroups (maybe choose depth at which to search)
- [ ] Add keybind that lets me vertically split from fzf
- [ ] Overseer task setup
  - [ ] CMake configure && build
  - [ ] Run test...?
- [ ] Set up cmp to handle autocompletion/hovering
  - [x] dockerfile
  - [x] CMake functions and other stuff
  - [ ]
- [ ] Fix the outline not seeing gtest functions.

# DONE

- [x] Add in bullet for markdown files (sorta finished, still needs confirmation that it is working in markdown)
- [x] Add in link for Windows desktop to work and personal .zshrc's
  - I don't think this is needed anymore. We can just use zoxide for skipping around
- [x] Add in dependency for pgAdmin4
  - There's a docker container for this, I don't need it...
- [x] Add commands for pandoc between word and md
  - This is easier than I thought to just do from command line
    (<https://www.pgadmin.org/download/pgadmin-4-apt/>)
- [x] Try octo
  - Octo only works for github
- [x] Add [tabby](https://github.com/nanozuki/tabby.nvim) for tabs rather than buffers...
- [x] Set up LuaSnip to add in VSCode snippets, and especially mermaid snippets
- [x] Markdown rendering
  - [x] Showing bullet points as different when I'm on that particular bullet point
- [x] Fix bullet having issues with lists/todo's (It might not be)
  - Has errors pop up each time I switch lines for some reason
- [x] Add in support for Obsidian from neovim
- [x] Make the cwd and root directory snacks explorer preview make some sense
  - Maybe make the root alt+e and cwd alt+E?
- [x] Change tab switch keybind and next todo keybind (todo gets capital T)
