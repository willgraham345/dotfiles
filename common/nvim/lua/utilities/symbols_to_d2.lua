-- lua/my_utils/symbols_to_d2.lua
-- Neovim Lua Module to Convert symbols.nvim Output to D2 Diagrams and copy to clipboard.

-- Configuration: Set to true to enable detailed debug notifications.
-- This can also be overridden by setting vim.g.symbols_to_d2_debug_enabled in your init.lua.
local DEBUG_MODE = true -- Changed to true by default

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
logger.set_level = function(l)
  level = l
end

--- Enables the logger.
logger.enable = function()
  enabled = true
end

--- Disables the logger.
logger.disable = function()
  enabled = false
end

-- List of common symbol types that symbols.nvim might output.
-- This helps in identifying the symbol type keyword at the beginning of a line.
-- Only 'class', 'struct', 'fun', 'fn', 'field', 'var', and 'enum' are processed for D2 output.
local SYMBOL_TYPES = {
  "class",
  "struct", -- FIXME: Isn't pullint non-keyword args. Fields are not counted.
  "fun",
  -- "fn", -- FIXME: Doesn't behave like it should...
  "field",
  -- "var", -- FIXME: Not sure if this is doing anything
  "enum", -- FIXME: Isn't pulling the next tabbed things. Fields are not counted
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

    -- First, find the earliest occurrence of any SYMBOL_TYPE keyword in the raw content
    for _, type_keyword in ipairs(SYMBOL_TYPES) do
      -- Use plain string.find for literal match, not pattern matching
      local start_idx = content_raw:find(type_keyword, 1, true)
      if start_idx then
        if start_idx < best_match_start_idx then
          best_match_start_idx = start_idx
          best_match_type_keyword = type_keyword
        end
      end
    end

    local content_for_parsing = content_raw
    if best_match_type_keyword then
      -- If a keyword was found, clean the content from its start index
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

      -- Now, try to extract type and name based on the found keyword
      -- The pattern now assumes the type_keyword is at the very beginning of content_for_parsing
      local pattern = "^" .. best_match_type_keyword .. "(%s*(.*))$"
      local name_part = content_for_parsing:match(pattern)
      if name_part then
        symbol_type = best_match_type_keyword
        symbol_name = name_part:gsub("^%s*", ""):gsub("%s*$", "")
        logger.debug(string.format("Line %d - Matched keyword '%s'. Name: '%s'", line_num, symbol_type, symbol_name))
      end
    end

    -- Fallback: Attempt to match the bracketed format if keyword pattern failed.
    -- This handles cases like "[class] MyClass" that might still appear.
    if not symbol_type then
      local bracketed_type, bracketed_name =
        content_raw:match("^[^\128-\191\224-\239\240-\244a-zA-Z0-9_]*%[(.-)%]%s*(.*)$")
      if bracketed_type then
        -- Check if the bracketed type is one of our allowed types
        for _, allowed_type in ipairs(SYMBOL_TYPES) do
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

    -- IMPORTANT: Filter based on the allowed types (class, struct, fun, fn, field, var, enum)
    -- If symbol_type is still nil or not in our SYMBOL_TYPES list, skip this line.
    local is_allowed_type = false
    for _, allowed_type in ipairs(SYMBOL_TYPES) do
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
    while #indent_stack > 0 and indent_stack[#indent_stack][1] >= current_indent do
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

    -- Generate D2 ID based only on the sanitized symbol name.
    -- WARNING: This can lead to non-unique D2 IDs if multiple symbols have the same name.
    -- D2 requires unique IDs. If you encounter errors, consider re-enabling a unique suffix (e.g., line number).
    local d2_id = symbol_name:gsub("[^a-zA-Z0-9_]", "_"):lower()

    -- Ensure ID starts with a letter or underscore if it doesn't already
    if not d2_id:match("^[a-zA-Z_]") then
      d2_id = "_" .. d2_id
    end

    local node = {
      name = symbol_name,
      type = symbol_type,
      children = {},
      indent = current_indent,
      id = d2_id,
    }
    table.insert(parent_node.children, node)
    table.insert(indent_stack, { current_indent, node })
    if DEBUG_MODE then
      vim.notify(
        string.format(
          "DEBUG: Line %d - Node '%s' added as child of '%s'. Stack size: %d",
          line_num,
          node.name,
          parent_node.name,
          #indent_stack
        ),
        vim.log.levels.DEBUG
      )
    logger.debug(string.format("Line %d - Generated D2 ID: '%s'", line_num, d2_id))
    end

    ::continue::
  end
  return root
  logger.debug("Finished parse_symbols_output function.")
end

-- Helper function to recursively generate D2 syntax
local function generate_d2(node, level)
  level = level or 0
  local d2_output = {}
  local indent_str = string.rep("  ", level)

  if node.type == "root" then
    logger.debug("generate_d2: Processing root node.")
    for _, child in ipairs(node.children) do
      table.insert(d2_output, generate_d2(child, level))
    end
    return table.concat(d2_output, "\n")
  end

  local d2_id = node.id
  local display_name = node.name
  local d2_type_prefix = node.type:gsub(" ", "_")
  logger.debug(string.format("generate_d2: Processing node '%s' (ID: %s) at level %d.", display_name, d2_id, level))

  -- Handle 'class', 'struct', and 'enum' types as D2 class shapes
  if node.type == "class" or node.type == "struct" or node.type == "enum" then
    table.insert(d2_output, string.format("%s%s: {", indent_str, d2_id))
    table.insert(d2_output, string.format('%s  label: "%s"', indent_str, display_name)) -- Just class/struct/enum name
    table.insert(d2_output, string.format("%s  shape: class", indent_str)) -- Add shape
    for _, child in ipairs(node.children) do
      -- Children of these containers are rendered directly inside
      if child.type == "fun" or child.type == "fn" then -- Handle 'fun' and 'fn'
        table.insert(d2_output, string.format("%s  %s()", indent_str, child.name))
      elseif child.type == "field" or child.type == "var" then -- Handle 'field' and 'var'
        table.insert(d2_output, string.format("%s  %s", indent_str, child.name))
      else
        -- If other types of children exist, they will be skipped based on this specific request.
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
    -- This block handles types that are not 'class', 'struct', or 'enum' and are not children
    -- of those types (e.g., if 'fun' or 'field' somehow appear at the root level).
    -- Based on the requested output, these should not generate D2.
    logger.debug(
      string.format(
        "generate_d2: Skipping node '%s' (type: %s) as it's not a 'class', 'struct', or 'enum' container.",
        display_name,
        node.type
      )
    return "" -- Do not generate D2 for standalone fun/fn/field/var nodes, or other unhandled types.
    )
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
  -- Using print for final debug output to avoid notification clutter
  print("Final D2 text generated:\n" .. text)
end

--- Main function to be called from Neovim.
--- It automatically finds the symbols.nvim buffer and processes its content.
function M.convert_symbols_buffer_to_d2()
  logger.debug("convert_symbols_buffer_to_d2 function called.")
  local symbols_buf_id = nil
  local symbols_buf_name = "symbols.nvim" -- Common name for symbols.nvim buffer

  -- Iterate through all buffers to find the symbols.nvim buffer
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

  -- Get all lines from the symbols.nvim buffer
  local raw_lines = vim.api.nvim_buf_get_lines(symbols_buf_id, 0, -1, false)
  logger.debug(string.format("Read %d raw lines from symbols.nvim buffer.", #raw_lines))

  local lines = {}
  -- Filter out potential empty lines or lines that are just whitespace
  for _, line in ipairs(raw_lines) do
    if line:match("%S") then -- Check if line contains any non-whitespace characters
      table.insert(lines, line)
    end
  end
  logger.debug(string.format("Filtered down to %d non-empty lines.", #lines))

  if #lines == 0 then
    vim.notify("symbols.nvim buffer is empty or contains no valid symbols.", vim.log.levels.INFO)
    return
  end

  local parsed_tree = parse_symbols_output(lines)
  local d2_diagram = generate_d2(parsed_tree)
  copy_to_clipboard(d2_diagram)
  logger.debug("convert_symbols_buffer_to_d2 function finished.")
end

return M
