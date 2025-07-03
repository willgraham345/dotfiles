-- lua/my_utils/symbols_to_d2.lua
-- Neovim Lua Module to Convert symbols.nvim Output to D2 Diagrams and copy to clipboard.

-- Configuration: Set to true to enable detailed debug notifications.
-- This can also be overridden by setting vim.g.symbols_to_d2_debug_enabled in your init.lua.
local DEBUG_MODE = true -- Changed to true by default

local M = {}

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
  if DEBUG_MODE then
    vim.notify("DEBUG: Starting parse_symbols_output function.", vim.log.levels.DEBUG)
  end
  local root = { name = "root", type = "root", children = {}, indent = -1 }
  local indent_stack = { { -1, root } }

  for line_num, line in ipairs(lines) do
    if DEBUG_MODE then
      vim.notify(string.format("DEBUG: Processing line %d: '%s'", line_num, line), vim.log.levels.DEBUG)
    end
    line = line:gsub("%s+$", "") -- Trim trailing whitespace
    if #line == 0 then
      if DEBUG_MODE then
        vim.notify(string.format("DEBUG: Line %d is empty, skipping.", line_num), vim.log.levels.DEBUG)
      end
      goto continue -- Skip empty lines
    end

    local current_indent = #line - #line:gsub("^%s*", "")
    local content_raw = line:gsub("^%s*", "") -- Remove leading whitespace (but keep tree chars for now)
    if DEBUG_MODE then
      vim.notify(
        string.format("DEBUG: Line %d - Indent: %d, Raw Content: '%s'", line_num, current_indent, content_raw),
        vim.log.levels.DEBUG
      )
    end

    local symbol_type = nil
    local symbol_name = nil

    local best_match_start_idx = math.huge -- Initialize with a very large number
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
      if DEBUG_MODE then
        vim.notify(
          string.format(
            "DEBUG: Line %d - Cleaned from keyword '%s' (idx %d): '%s'",
            line_num,
            best_match_type_keyword,
            best_match_start_idx,
            content_for_parsing
          ),
          vim.log.levels.DEBUG
        )
      end

      -- Now, try to extract type and name based on the found keyword
      -- The pattern now assumes the type_keyword is at the very beginning of content_for_parsing
      local pattern = "^" .. best_match_type_keyword .. "(%s*(.*))$"
      local name_part = content_for_parsing:match(pattern)
      if name_part then
        symbol_type = best_match_type_keyword
        symbol_name = name_part:gsub("^%s*", ""):gsub("%s*$", "") -- Trim spaces around the name
        if DEBUG_MODE then
          vim.notify(
            string.format("DEBUG: Line %d - Matched keyword '%s'. Name: '%s'", line_num, symbol_type, symbol_name),
            vim.log.levels.DEBUG
          )
        end
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
            if DEBUG_MODE then
              vim.notify(
                string.format(
                  "DEBUG: Line %d - Matched bracketed pattern. Type: '%s', Name: '%s'",
                  line_num,
                  symbol_type,
                  symbol_name
                ),
                vim.log.levels.DEBUG
              )
            end
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
      if DEBUG_MODE then
        vim.notify(
          string.format(
            "DEBUG: Line %d - Skipping, type '%s' not in allowed list or not recognized.",
            line_num,
            symbol_type or "nil"
          ),
          vim.log.levels.DEBUG
        )
      end
      goto continue
    end

    if #symbol_name == 0 then
      vim.notify(
        string.format("Warning: Could not parse symbol name from line %d: '%s'. Skipping.", line_num, line),
        vim.log.levels.WARN
      )
      goto continue
    end

    if DEBUG_MODE then
      vim.notify(
        string.format("DEBUG: Line %d - Final Parsed Type: '%s', Name: '%s'", line_num, symbol_type, symbol_name),
        vim.log.levels.DEBUG
      )
    end

    -- Find the correct parent based on indentation
    local prev_stack_size = #indent_stack
    while #indent_stack > 0 and indent_stack[#indent_stack][1] >= current_indent do
      table.remove(indent_stack)
    end
    if DEBUG_MODE then
      vim.notify(
        string.format(
          "DEBUG: Line %d - Indent stack size changed from %d to %d after popping.",
          line_num,
          prev_stack_size,
          #indent_stack
        ),
        vim.log.levels.DEBUG
      )
    end

    if #indent_stack == 0 then
      vim.notify(
        string.format("Error: Invalid indentation at line %d: '%s'. Cannot find parent.", line_num, line),
        vim.log.levels.ERROR
      )
      goto continue
    end

    local parent_indent, parent_node = unpack(indent_stack[#indent_stack])
    if DEBUG_MODE then
      vim.notify(
        string.format("DEBUG: Line %d - Parent found: '%s' (indent %d)", line_num, parent_node.name, parent_indent),
        vim.log.levels.DEBUG
      )
    end

    -- Generate D2 ID based only on the sanitized symbol name.
    -- WARNING: This can lead to non-unique D2 IDs if multiple symbols have the same name.
    -- D2 requires unique IDs. If you encounter errors, consider re-enabling a unique suffix (e.g., line number).
    local d2_id = symbol_name:gsub("[^a-zA-Z0-9_]", "_"):lower()

    -- Ensure ID starts with a letter or underscore if it doesn't already
    if not d2_id:match("^[a-zA-Z_]") then
      d2_id = "_" .. d2_id
    end
    if DEBUG_MODE then
      vim.notify(string.format("DEBUG: Line %d - Generated D2 ID: '%s'", line_num, d2_id), vim.log.levels.DEBUG)
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
    end

    ::continue::
  end
  if DEBUG_MODE then
    vim.notify("DEBUG: Finished parse_symbols_output function.", vim.log.levels.DEBUG)
  end
  return root
end

-- Helper function to recursively generate D2 syntax
local function generate_d2(node, level)
  level = level or 0
  local d2_output = {}
  local indent_str = string.rep("  ", level)

  if node.type == "root" then
    if DEBUG_MODE then
      vim.notify("DEBUG: generate_d2: Processing root node.", vim.log.levels.DEBUG)
    end
    for _, child in ipairs(node.children) do
      table.insert(d2_output, generate_d2(child, level))
    end
    return table.concat(d2_output, "\n")
  end

  local d2_id = node.id
  local display_name = node.name
  local d2_type_prefix = node.type:gsub(" ", "_")
  if DEBUG_MODE then
    vim.notify(
      string.format("DEBUG: generate_d2: Processing node '%s' (ID: %s) at level %d.", display_name, d2_id, level),
      vim.log.levels.DEBUG
    )
  end

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
        if DEBUG_MODE then
          vim.notify(
            string.format(
              "DEBUG: generate_d2: Skipping non-fun/fn/field/var child of class/struct/enum: '%s' (type: %s)",
              child.name,
              child.type
            ),
            vim.log.levels.DEBUG
          )
        end
      end
    end
    table.insert(d2_output, string.format("%s}", indent_str))
  else
    -- This block handles types that are not 'class', 'struct', or 'enum' and are not children
    -- of those types (e.g., if 'fun' or 'field' somehow appear at the root level).
    -- Based on the requested output, these should not generate D2.
    if DEBUG_MODE then
      vim.notify(
        string.format(
          "DEBUG: generate_d2: Skipping node '%s' (type: %s) as it's not a 'class', 'struct', or 'enum' container.",
          display_name,
          node.type
        ),
        vim.log.levels.DEBUG
      )
    end
    return "" -- Do not generate D2 for standalone fun/fn/field/var nodes, or other unhandled types.
  end

  return table.concat(d2_output, "\n")
end

-- Helper function to copy text to Neovim's clipboard register
local function copy_to_clipboard(text)
  if DEBUG_MODE then
    vim.notify("DEBUG: Attempting to copy to clipboard.", vim.log.levels.DEBUG)
  end
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
  if DEBUG_MODE then
    -- Using print for final debug output to avoid notification clutter
    print("DEBUG: Final D2 text generated:\n" .. text)
  end
end

--- Main function to be called from Neovim.
--- It automatically finds the symbols.nvim buffer and processes its content.
function M.convert_symbols_buffer_to_d2()
  -- Check for global override for DEBUG_MODE
  if vim.g.symbols_to_d2_debug_enabled ~= nil then
    DEBUG_MODE = vim.g.symbols_to_d2_debug_enabled
  end

  if DEBUG_MODE then
    vim.notify("DEBUG: convert_symbols_buffer_to_d2 function called.", vim.log.levels.DEBUG)
  end
  local symbols_buf_id = nil
  local symbols_buf_name = "symbols.nvim" -- Common name for symbols.nvim buffer

  -- Iterate through all buffers to find the symbols.nvim buffer
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf_id) then
      local filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")
      local buf_name = vim.api.nvim_buf_get_name(buf_id)
      if DEBUG_MODE then
        vim.notify(
          string.format("DEBUG: Checking buffer ID %d: filetype='%s', name='%s'", buf_id, filetype, buf_name),
          vim.log.levels.DEBUG
        )
      end

      if filetype == "SymbolsSidebar" or buf_name == symbols_buf_name then
        symbols_buf_id = buf_id
        if DEBUG_MODE then
          vim.notify(
            string.format("DEBUG: Found symbols.nvim buffer with ID: %d", symbols_buf_id),
            vim.log.levels.DEBUG
          )
        end
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
  if DEBUG_MODE then
    vim.notify(string.format("DEBUG: Read %d raw lines from symbols.nvim buffer.", #raw_lines), vim.log.levels.DEBUG)
  end

  local lines = {}
  -- Filter out potential empty lines or lines that are just whitespace
  for _, line in ipairs(raw_lines) do
    if line:match("%S") then -- Check if line contains any non-whitespace characters
      table.insert(lines, line)
    end
  end
  if DEBUG_MODE then
    vim.notify(string.format("DEBUG: Filtered down to %d non-empty lines.", #lines), vim.log.levels.DEBUG)
  end

  if #lines == 0 then
    vim.notify("symbols.nvim buffer is empty or contains no valid symbols.", vim.log.levels.INFO)
    return
  end

  local parsed_tree = parse_symbols_output(lines)
  local d2_diagram = generate_d2(parsed_tree)
  copy_to_clipboard(d2_diagram)
  if DEBUG_MODE then
    vim.notify("DEBUG: convert_symbols_buffer_to_d2 function finished.", vim.log.levels.DEBUG)
  end
end

return M
