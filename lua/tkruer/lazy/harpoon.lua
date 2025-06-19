return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    local list = harpoon:list()
    local ui = require("harpoon.ui")
    local map = vim.keymap.set
    local opt = { noremap = true, silent = true }

    map("n", "<leader>ha", function()
      vim.notify("󰛢 Harpooned file")
      list:add()
    end, opt)
    map("n", "<leader>hm", function()
      ui:toggle_quick_menu(list)
    end, opt)
    map("n", "<leader>1", function()
      list:select(1)
    end, opt)
    map("n", "<leader>2", function()
      list:select(2)
    end, opt)
    map("n", "<leader>3", function()
      list:select(3)
    end, opt)
    map("n", "<leader>4", function()
      list:select(4)
    end, opt)
    require("telescope").load_extension("harpoon")

    map("n", "<leader>fh", "<cmd>Telescope harpoon marks<CR>", { desc = "Harpoon marks (Telescope)" })

    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function add_to_harpoon(prompt_bufnr)
      local entry = action_state.get_selected_entry()
      local file = entry.path or entry.filename
      harpoon:list():add({
        value = file,
        context = { row = 1, col = 1 },
      })
      vim.notify("󰛢 Harpooned: " .. (entry.path or entry.filename))
    end

    require("telescope").setup({
      defaults = {
        mappings = {
          i = { ["<C-h>"] = add_to_harpoon },
          n = { ["m"] = add_to_harpoon },
        },
      },
    })
  end,
}
