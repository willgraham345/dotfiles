# TODO

## Learning

## nvim/keyboard

- [ ] Set up mimeapps.list stuff @priority(medium)
- [ ] Set up chemoix for dotfiles @priority(high)
- [ ] Set up [macro saver](https://github.com/kr40/nvim-macros) @priority(high)
- [ ] Set up puml snippets @priority(medium)
- [ ] Change ctrl+click and ctrl+space on keyboard @priority(medium)
- [ ] whichkey icon and group setup #nice_to_have @priority(low)
- [ ] Fix cpp snippets, they're not working @priority(low)
- [ ] Set up image/diagram nvim on cmd wsl @priority(low)
- [ ] Start porting over Obsidian commands into Navi Cheatsheets @priority(low)
- [x] Update personal zshrc to match work zshrc. @priority(medium) @done(08/18/25 09:01)

## obsidian

- [ ] Fix the new project thing on Work/SDL @priority(high)
  - Should automatically go to its own folder
- [ ] Reformat generics in rust to make more sense @priority(high)
- [ ] Better filtering for obsidian breadcrumb group relationships @priority(low)
- [ ] Fix query for dataviewJS within a project @priority(medium)
  - [ ] Add better dataviewJS for command and code queries #high_priority @priority(low)
    - [ ] Figure out how I want to handle the [E] tag group
    - This thing could be a part of each [I]. Basically, all the [E]'s are children of the I's

## other

- [ ] Look into [task-warrior](https://github.com/GothenburgBitFactory/taskwarrior?tab=readme-ov-file)
- [ ] Add `$BROWSWER` variable into personal `.zshrc`

# DONE

## Archive

- [x] Set up Navi cheatsheets
- [x] Find a way to avoid ignoring todo.md files for the dotfiles repo, but not other repos else @priority(medium)
- [x] Modify the dapui.setup (:h dapui.setup()) to have smaller values for everything other than watch and stacks... @done(07/15/25 13:59)
- [x] Add keybind that lets me vertically split from fzf #nice_to_have @done(07/15/25 13:58)
- [x] Fix queries (maybe make a base?) for the task/lists within a project (waiting until bases is out) @done(07/16/25 09:34)
- [x] Sort by tag group and tag subgroups (maybe choose depth at which to search) @priority() @done(07/15/25 13:58)
- [x] Add in bullet for markdown files (sorta finished, still needs confirmation that it is working in markdown) @done(07/15/25 13:56)
- [x] Add in link for Windows desktop to work and personal .zshrc's @done(07/15/25 13:56)
  - I don't think this is needed anymore. We can just use zoxide for skipping around
- [x] Add in dependency for pgAdmin4 @done(07/15/25 13:56)
  - There's a docker container for this, I don't need it...
- [x] Add commands for pandoc between word and md @done(07/15/25 13:56)
  - This is easier than I thought to just do from command line
    (<https://www.pgadmin.org/download/pgadmin-4-apt/>)
- [x] Try octo @done(07/15/25 13:56)
  - Octo only works for github
- [x] Add [tabby](https://github.com/nanozuki/tabby.nvim) for tabs rather than buffers... @done(07/15/25 13:56)
- [x] Set up LuaSnip to add in VSCode snippets, and especially mermaid snippets @done(07/15/25 13:56)
- [x] Markdown rendering @done(07/15/25 13:56)
  - [x] Showing bullet points as different when I'm on that particular bullet point @done(07/15/25 13:56)
- [x] Fix bullet having issues with lists/todo's (It might not be) @done(07/15/25 13:56)
  - Has errors pop up each time I switch lines for some reason
- [x] Add in support for Obsidian from neovim @done(07/15/25 13:56)
- [x] Make the cwd and root directory snacks explorer preview make some sense @done(07/15/25 13:56)
  - Maybe make the root alt+e and cwd alt+E?
- [x] Change tab switch keybind and next todo keybind (todo gets capital T) @done(07/15/25 13:56)
- [x] Add in [tabby](https://github.com/nanozuki/tabby.nvim?tab=readme-ov-file) extension (Instead, opted to keep bufferline as it could rename tabs like I wanted it to) @done(07/15/25 13:56)
- [x] Add templater/quickAdd for adding new headings @done(07/15/25 13:56)
- [x] Fix the outline not seeing gtest functions. (all I did was removed the filter lazyvim had installed by default) @done(07/15/25 13:56)
- [x] Set up cmp to handle autocompletion/hovering @done(07/15/25 13:56)
  - [x] dockerfile @done(07/15/25 13:56)
  - [x] CMake functions and other stuff @done(07/15/25 13:56)
- [x] Keymaps @done(07/15/25 13:56)
  - [x] consider turning off default keymaps for lazyvim @done(07/15/25 13:56)
  - [x] Add delete buffers to left/right keymaps @done(07/15/25 13:56)
  - [x] Add [[ to aerial rather than snacks default @done(07/15/25 13:56)
  - [x] Make keymap to delete the matching "([{" on end of a string @done(07/15/25 13:56)
  - [x] Add "[," for next comma @done(07/15/25 13:56)
- [x] Neotest setup @done(07/15/25 13:56)
- [x] Finish up cmake setup @done(07/15/25 13:56)
  - [x] Add a cmake kit to zshrc and write it to .config somewhere @done(07/15/25 13:56)
  - [x] Add configuration to use Ninja @done(07/15/25 13:56)
  - [x] Add configuration to use ctest @done(07/15/25 13:56)
- [x] Change ~ and \` in oryx config #high_priority #oryx @done(07/15/25 13:56)
  - [x] Look into using the two thumbkeys @done(07/15/25 13:56)
- [x] Set up rustaceanvim use the `--nocapture` arg with the dap @done(07/15/25 13:56)
- [x] Set up mini.files (enter to open and close file/preview) @done(07/15/25 13:56)
- [x] Set up BibLib with current citations @done(07/15/25 13:56)
- [x] Set up anki quizzing from Obsidian work @done(07/15/25 13:56)
