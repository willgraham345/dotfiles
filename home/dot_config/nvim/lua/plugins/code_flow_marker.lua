-- Simplified node marker
local M = {}

local ns = vim.api.nvim_create_namespace("my_graph_nodes")
local db_path = vim.fn.stdpath("data") .. "/my_nodes.json"
local nodes = {}

function M.load_nodes()
  local f = io.open(db_path, "r")
  if f then
    nodes = vim.json.decode(f:read("*a")) or {}
    f:close()
  end
end

function M.save_nodes()
  local f = io.open(db_path, "w")
  f:write(vim.json.encode(nodes))
  f:close()
end

function M.add_node(label, id, opts)
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local file = vim.api.nvim_buf_get_name(bufnr)

  local extmark_id = vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
    hl_group = "Todo",
    virt_text = {{ "● " .. label, "Comment" }},
    virt_text_pos = "eol",
    user_data = { id = id, label = label },
  })

  table.insert(nodes, {
    id = id,
    label = label,
    file = file,
    line = row,
    extmark_id = extmark_id,
    timestamp = os.date("%Y-%m-%dT%H:%M:%S"),
    order = #nodes + 1,
    note = opts and opts.note or "",
  })

  M.save_nodes()
end

-- return M

-- TODO: Not working, needs additional work
return {
  -- "nvim-lua/plenary.nvim", -- if you extend it later
  -- config = function()
  --   local marker = M
  --
  --   -- vim.keymap.set("n", "<leader>an", function()
  --   --   marker.add_node("Step", "step_" .. os.time(), { note = "Details..." })
  --   -- end, { desc = "Add Flow Node" })
  --   --
  --   -- vim.keymap.set("n", "<leader>ap", function()
  --   --   marker.preview_diagram()
  --   -- end, { desc = "Preview Flow Graph" })
  --   --
  --   -- vim.keymap.set("n", "<leader>ac", function()
  --   --   marker.clear_nodes()
  --   -- end, { desc = "Clear Flow Nodes" })
  -- end,
}

