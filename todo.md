# TODO

## nvim

- [ ] Set up image/diagram nvim on cmd wsl
- [ ] whichkey icon and group setup #nice_to_have
- [ ] See if outline has a "freeze" toggle #nice_to_have
- [ ] Fix cpp snippets, they're not working #nice_to_have
- [ ] Add keybind that lets me vertically split from fzf #nice_to_have

## other

- [ ] Change ~ and \` in oryx config #high_priority
- [ ] Better filtering for obsidian breadcrumb group relationships
- [ ] Fix query for dataviewJS within a project
- [ ] Add better dataviewJS for command and code queries #high_priority
  - [ ] Sort by tag group and tag subgroups (maybe choose depth at which to search)

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
- [x] Add in [tabby](https://github.com/nanozuki/tabby.nvim?tab=readme-ov-file) extension (Instead, opted to keep bufferline as it could rename tabs like I wanted it to)
- [x] Add templater/quickAdd for adding new headings
- [x] Fix the outline not seeing gtest functions. (all I did was removed the filter lazyvim had installed by default)
- [x] Set up cmp to handle autocompletion/hovering
  - [x] dockerfile
  - [x] CMake functions and other stuff
- [x] Keymaps
  - [x] consider turning off default keymaps for lazyvim
  - [x] Add delete buffers to left/right keymaps
  - [x] Add [[ to aerial rather than snacks default
  - [x] Make keymap to delete the matching "([{" on end of a string
  - [x] Add "[," for next comma
- [x] Neotest setup
- [x] Finish up cmake setup
  - [x] Add a cmake kit to zshrc and write it to .config somewhere
  - [x] Add configuration to use Ninja
  - [x] Add configuration to use ctest
