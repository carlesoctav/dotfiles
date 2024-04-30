return { 
  {
    'z0rzi/ai-chat.nvim',
    config = function()
      require('ai-chat').setup {
        {
          mappings = {
            focus_window = '<leader>tc',

            -- Sends the selected text to the chat, and starts insert mode
            selected_to_chat = '<leader>tc',

            run_macro = '<nop>',

            edit_macro = '<nop>',

            open_chat_in_current_buffer = '<leader>ta',
            next_hunk = ']]',
            prev_hunk = '[[',

            next_core = '}}',
            prev_core = '{{',

            -- Sends a message to the AI
            send_message = '<C-a>',

            -- Removes all the messages from the chat
            reset_chat = '<C-d>'
          },

          -- If the provided bun executable doesn't work for you, you can specify a path here
          bun_executable = nil,

          -- The core instructions to load at startup
          core_instructions = 'code',

          files = {
            -- The place where the current chat is saved
            chat_file = os.getenv("HOME") .. '/.config/ai-chat/chat.md',

            -- The directory where the macros are saved
            macros_dir = os.getenv("HOME") .. '/.config/ai-chat/macros/',

            -- The place where the core instructions are saved
            cores_dir = os.getenv("HOME") .. '/.config/ai-chat/cores/'
          }
        }
      }
    end,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require('copilot').setup({
  --       panel = {
  --         enabled = true,
  --         auto_refresh = false,
  --         keymap = {
  --           jump_prev = "[[",
  --           jump_next = "]]",
  --           accept = "<CR>",
  --           refresh = "gr",
  --           open = "<M-CR>"
  --         },
  --         layout = {
  --           position = "bottom", -- | top | left | right
  --           ratio = 0.4
  --         },
  --       },
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = false,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<C-y>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<C-j>",
  --           prev = "<C-k>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --       filetypes = {
  --         yaml = false,
  --         markdown = false,
  --         help = false,
  --         gitcommit = false,
  --         gitrebase = false,
  --         hgcommit = false,
  --         svn = false,
  --         cvs = false,
  --         ["."] = false,
  --       },
  --       copilot_node_command = 'node', -- Node.js version must be > 18.x
  --       server_opts_overrides = {},
  --     })
  --   end,
  -- }
}
