-- lua/my_utils/symbols_to_d2.lua
-- Neovim Lua Module to Convert symbols.nvim Output to D2 Diagrams and copy to clipboard.

local M = {}

-- A simple logger module to replace debug statements.
local logger = {}
local enabled = true
local level = "DEBUG" -- Default log level
local levels = {
  DEBUG = 1,
  INFO = 2,
  WARN = 3,
  ERROR = 4,
}

--- Logs a message if logging is enabled and the message's level is sufficient.
--- @param msg_level string The level of the message (e.g., "DEBUG", "INFO").
--- @param msg string The message to log.
local function log(msg_level, msg)
  if enabled and levels[msg_level] and levels[msg_level] >= levels[level] then
    vim.api.nvim_echo({ { "[" .. msg_level .. "] " .. msg, "None" } }, true, {})
  end
end

logger.debug = function(msg)
  log("DEBUG", msg)
end
logger.info = function(msg)
  log("INFO", msg)
end
logger.warn = function(msg)
  log("WARN", msg)
end
logger.error = function(msg)
  log("ERROR", msg)
end

--- Sets the minimum log level to display.
--- @param l string The new log level (e.g., "DEBUG", "INFO", "WARN", "ERROR").
local function set_level(l)
  level = l
end

--- Enables the logger.
local function enable_logger()
  enabled = true
end

--- Disables the logger.
local function disable_logger()
  enabled = false
end

-- List of common symbol types that symbols.nvim might output.
-- These are the "normal" types that are not language-specific interfaces.
local SYMBOL_TYPES = {
  "class",
  "struct",
  "fun",
  "fn",
  "field",
  "var",
  "enum",
}

-- New, separate lists for language-specific interface keywords.
-- This makes the parsing logic more explicit and modular.
local LANGUAGE_INTERFACES = {
  cpp = { "virtual" },
  rust = { "trait" },
}

-- Create a pattern for matching any of the defined symbol types
local SYMBOL_TYPE_PATTERN = table.concat(SYMBOL_TYPES, "|")

-- Helper function to parse symbols.nvim-like output
-- Assumes each line represents a symbol with an indentation indicating its level.
-- It now handles leading non-alphanumeric characters and looks for keyword types.
local function parse_symbols_output(lines)
  logger.debug("Starting parse_symbols_output function.")
  local root = { name = "root", type = "root", children = {}, indent = -1 }
  local indent_stack = { { -1, root } }
  -- New table to store interface relationships for later processing
  local interface_implementations = {}

  for line_num, line in ipairs(lines) do
    logger.debug(string.format("Processing line %d: '%s'", line_num, line))
    line = line:gsub("%s+$", "") -- Trim trailing whitespace
    if #line == 0 then
      logger.debug(string.format("Line %d is empty, skipping.", line_num))
      goto continue -- Skip empty lines
    end

    local current_indent = #line - #line:gsub("^%s*", "")
    local content_raw = line:gsub("^%s*", "") -- Remove leading whitespace (but keep tree chars for now)
    logger.debug(string.format("Line %d - Indent: %d, Raw Content: '%s'", line_num, current_indent, content_raw))

    local symbol_type = nil
    local symbol_name = nil

    local best_match_start_idx = math.huge
    local best_match_type_keyword = nil

    -- Check for normal symbol types first
    for _, type_keyword in ipairs(SYMBOL_TYPES) do
      local start_idx = content_raw:find(type_keyword, 1, true)
      if start_idx then
        if start_idx < best_match_start_idx then
          best_match_start_idx = start_idx
          best_match_type_keyword = type_keyword
        end
      end
    end

    -- If no normal symbol type was found, check for language-specific interfaces
    if not best_match_type_keyword then
      for lang, keywords in pairs(LANGUAGE_INTERFACES) do
        for _, type_keyword in ipairs(keywords) do
          local start_idx = content_raw:find(type_keyword, 1, true)
          if start_idx then
            if start_idx < best_match_start_idx then
              best_match_start_idx = start_idx
              best_match_type_keyword = type_keyword
            end
          end
        end
      end
    end

    local content_for_parsing = content_raw
    if best_match_type_keyword then
      content_for_parsing = content_raw:sub(best_match_start_idx)
      logger.debug(
        string.format(
          "Line %d - Cleaned from keyword '%s' (idx %d): '%s'",
          line_num,
          best_match_type_keyword,
          best_match_start_idx,
          content_for_parsing
        )
      )

      local pattern = "^" .. best_match_type_keyword .. "(%s*(.*))$"
      local name_part = content_for_parsing:match(pattern)
      if name_part then
        symbol_type = best_match_type_keyword
        symbol_name = name_part:gsub("^%s*", ""):gsub("%s*$", "")
        logger.debug(string.format("Line %d - Matched keyword '%s'. Name: '%s'", line_num, symbol_type, symbol_name))
      end
    end

    if not symbol_type then
      local bracketed_type, bracketed_name =
        content_raw:match("^[^\128-\191\224-\239\240-\244a-zA-Z0-9_]*%[(.-)%]%s*(.*)$")
      if bracketed_type then
        -- Check if the bracketed type is one of our allowed types (including interfaces)
        local all_allowed_types = {}
        for _, v in ipairs(SYMBOL_TYPES) do
          table.insert(all_allowed_types, v)
        end
        for _, v in pairs(LANGUAGE_INTERFACES) do
          for _, keyword in ipairs(v) do
            table.insert(all_allowed_types, keyword)
          end
        end

        for _, allowed_type in ipairs(all_allowed_types) do
          if bracketed_type:lower() == allowed_type:lower() then
            symbol_type = allowed_type
            symbol_name = bracketed_name:gsub("^%s*", ""):gsub("%s*$", "")
            logger.debug(
              string.format(
                "Line %d - Matched bracketed pattern. Type: '%s', Name: '%s'",
                line_num,
                symbol_type,
                symbol_name
              )
            )
            break
          end
        end
      end
    end

    local is_allowed_type = false
    local all_allowed_types = {}
    for _, v in ipairs(SYMBOL_TYPES) do
      table.insert(all_allowed_types, v)
    end
    for _, v in pairs(LANGUAGE_INTERFACES) do
      for _, keyword in ipairs(v) do
        table.insert(all_allowed_types, keyword)
      end
    end
    for _, allowed_type in ipairs(all_allowed_types) do
      if symbol_type == allowed_type then
        is_allowed_type = true
        break
      end
    end

    if not is_allowed_type then
      logger.debug(
        string.format(
          "Line %d - Skipping, type '%s' not in allowed list or not recognized.",
          line_num,
          symbol_type or "nil"
        )
      )
      goto continue
    end

    if #symbol_name == 0 then
      logger.warn(string.format("Could not parse symbol name from line %d: '%s'. Skipping.", line_num, line))
      goto continue
    end

    logger.debug(string.format("Line %d - Final Parsed Type: '%s', Name: '%s'", line_num, symbol_type, symbol_name))

    local prev_stack_size = #indent_stack
    -- Defensive check to prevent comparing a nil value.
    while #indent_stack > 0 and indent_stack[#indent_stack] and indent_stack[#indent_stack][1] >= current_indent do
      table.remove(indent_stack)
    end
    logger.debug(
      string.format(
        "Line %d - Indent stack size changed from %d to %d after popping.",
        line_num,
        prev_stack_size,
        #indent_stack
      )
    )

    if #indent_stack == 0 then
      logger.error(string.format("Invalid indentation at line %d: '%s'. Cannot find parent.", line_num, line))
      goto continue
    end

    local parent_indent, parent_node = unpack(indent_stack[#indent_stack])
    logger.debug(string.format("Line %d - Parent found: '%s' (indent %d)", line_num, parent_node.name, parent_indent))

    local d2_id = symbol_name:gsub("[^a-zA-Z0-9_]", "_"):lower()
    if not d2_id:match("^[a-zA-Z_]") then
      d2_id = "_" .. d2_id
    end
    -- Add line number to guarantee unique D2 IDs
    d2_id = d2_id .. "_" .. line_num
    logger.debug(string.format("Line %d - Generated D2 ID: '%s'", line_num, d2_id))

    -- Check for interface types and store them separately
    local is_interface_type = false
    for _, keywords in pairs(LANGUAGE_INTERFACES) do
      for _, keyword in ipairs(keywords) do
        if symbol_type == keyword then
          is_interface_type = true
          break
        end
      end
      if is_interface_type then
        break
      end
    end

    if is_interface_type then
      -- The parent is the class/struct that implements this interface.
      local implementing_id = parent_node.id
      -- Create a unique ID for the interface node itself, based on its name.
      local interface_id = symbol_name:gsub("[^a-zA-Z0-9_]", "_"):lower() .. "_interface"

      -- If the interface doesn't exist in our table, create a new entry for it.
      if not interface_implementations[interface_id] then
        interface_implementations[interface_id] = { name = symbol_name, implementors = {} }
      end
      -- Add the implementing class/struct to the list of implementors for this interface.
      table.insert(interface_implementations[interface_id].implementors, implementing_id)

      -- Add the interface method itself to its parent node (the class/struct)
      -- for display inside the class shape.
      local node = {
        name = symbol_name,
        type = symbol_type,
        children = {},
        indent = current_indent,
        id = d2_id,
      }
      table.insert(parent_node.children, node)
      table.insert(indent_stack, { current_indent, node })
    else
      local node = {
        name = symbol_name,
        type = symbol_type,
        children = {},
        indent = current_indent,
        id = d2_id,
      }
      table.insert(parent_node.children, node)
      table.insert(indent_stack, { current_indent, node })
    end

    ::continue::
  end
  logger.debug("Finished parse_symbols_output function.")
  return root, interface_implementations
end

-- Helper function to recursively generate D2 syntax
local function generate_d2(node, level, all_interfaces)
  level = level or 0
  local d2_output = {}
  local indent_str = string.rep("  ", level)

  if node.type == "root" then
    logger.debug("generate_d2: Processing root node.")
    for _, child in ipairs(node.children) do
      table.insert(d2_output, generate_d2(child, level, all_interfaces))
    end

    -- Add the interfaces at the end of the root level
    for interface_id, interface_data in pairs(all_interfaces) do
      local display_name = string.format("%s\n<interface>", interface_data.name)
      table.insert(d2_output, string.format("%s%s: {", indent_str, interface_id))
      table.insert(d2_output, string.format('%s  label: "%s"', indent_str, display_name))
      table.insert(d2_output, string.format("%s  shape: class", indent_str))
      table.insert(d2_output, string.format("%s}", indent_str))
      -- Add connections from implementors to the interface
      for _, implementor_id in ipairs(interface_data.implementors) do
        table.insert(d2_output, string.format('%s%s -> %s: "implements"', indent_str, implementor_id, interface_id))
      end
    end

    return table.concat(d2_output, "\n")
  end

  local d2_id = node.id
  local display_name = node.name
  logger.debug(string.format("generate_d2: Processing node '%s' (ID: %s) at level %d.", display_name, d2_id, level))

  if node.type == "class" or node.type == "struct" or node.type == "enum" then
    table.insert(d2_output, string.format("%s%s: {", indent_str, d2_id))
    table.insert(d2_output, string.format('%s  label: "%s"', indent_str, display_name))
    table.insert(d2_output, string.format("%s  shape: class", indent_str))
    for _, child in ipairs(node.children) do
      if child.type == "fun" or child.type == "fn" or child.type == "virtual" or child.type == "trait" then
        table.insert(d2_output, string.format("%s  %s()", indent_str, child.name))
      elseif child.type == "field" or child.type == "var" then
        table.insert(d2_output, string.format("%s  %s", indent_str, child.name))
      else
        logger.debug(
          string.format(
            "generate_d2: Skipping non-fun/fn/field/var child of class/struct/enum: '%s' (type: %s)",
            child.name,
            child.type
          )
        )
      end
    end
    table.insert(d2_output, string.format("%s}", indent_str))
  else
    logger.debug(
      string.format(
        "generate_d2: Skipping node '%s' (type: %s) as it's not a 'class', 'struct', or 'enum' container.",
        display_name,
        node.type
      )
    )
    return ""
  end

  return table.concat(d2_output, "\n")
end

-- Helper function to copy text to Neovim's clipboard register
local function copy_to_clipboard(text)
  logger.debug("Attempting to copy to clipboard.")
  local success, err = pcall(vim.fn.setreg, "+", text)
  if success then
    vim.notify("D2 diagram text copied to clipboard!", vim.log.levels.INFO)
  else
    vim.notify(
      "ERROR: Failed to copy to clipboard. Please ensure you have a clipboard provider (e.g., xclip, pbcopy, win32yank) installed and Neovim's 'clipboard' option is set correctly (e.g., ':set clipboard+=unnamedplus'). Error: "
        .. tostring(err),
      vim.log.levels.ERROR
    )
  end
  -- Using the logger for the final debug output
  logger.debug("Final D2 text generated:\n" .. text)
end

--- Main function to be called from Neovim.
--- It automatically finds the symbols.nvim buffer and processes its content.
function M.convert_symbols_buffer_to_d2()
  logger.debug("convert_symbols_buffer_to_d2 function called.")
  local symbols_buf_id = nil
  local symbols_buf_name = "symbols.nvim"

  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf_id) then
      local filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")
      local buf_name = vim.api.nvim_buf_get_name(buf_id)
      logger.debug(string.format("Checking buffer ID %d: filetype='%s', name='%s'", buf_id, filetype, buf_name))

      if filetype == "SymbolsSidebar" or buf_name == symbols_buf_name then
        symbols_buf_id = buf_id
        logger.debug(string.format("Found symbols.nvim buffer with ID: %d", symbols_buf_id))
        break
      end
    end
  end

  if not symbols_buf_id then
    vim.notify("symbols.nvim buffer not found. Please open SymbolsOutline first.", vim.log.levels.ERROR)
    return
  end

  local raw_lines = vim.api.nvim_buf_get_lines(symbols_buf_id, 0, -1, false)
  logger.debug(string.format("Read %d raw lines from symbols.nvim buffer.", #raw_lines))

  local lines = {}
  for _, line in ipairs(raw_lines) do
    if line:match("%S") then
      table.insert(lines, line)
    end
  end
  logger.debug(string.format("Filtered down to %d non-empty lines.", #lines))

  if #lines == 0 then
    vim.notify("symbols.nvim buffer is empty or contains no valid symbols.", vim.log.levels.INFO)
    return
  end

  local parsed_tree, interface_implementations = parse_symbols_output(lines)
  local d2_diagram = generate_d2(parsed_tree, nil, interface_implementations)
  copy_to_clipboard(d2_diagram)
  logger.debug("convert_symbols_buffer_to_d2 function finished.")
end

--- Enables the debug mode, setting the logger's level to DEBUG.
function M.enable_debug_mode()
  enable_logger()
  set_level("DEBUG")
  vim.notify("Debug mode enabled!", vim.log.levels.INFO)
end

--- Disables the debug mode.
function M.disable_debug_mode()
  disable_logger()
  vim.notify("Debug mode disabled.", vim.log.levels.INFO)
end

--- Sets the minimum log level to display while in debug mode.
--- @param level_str string The new log level (e.g., "DEBUG", "INFO", "WARN", "ERROR").
function M.set_debug_level(level_str)
  set_level(level_str)
  vim.notify("Log level set to: " .. level_str, vim.log.levels.INFO)
end

return M
