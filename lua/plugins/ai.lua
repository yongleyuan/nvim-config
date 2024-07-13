return {
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<S-Space>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true, desc = 'Codeium accept' })

      -- vim.keymap.set('i', '<C-\\>', function()
      --   return vim.fn['codeium#Complete']()
      -- end, { expr = true, silent = true, desc = 'Codeium complete' })

      vim.keymap.set('i', '<C-j>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true, desc = 'Codeium cycle previous' })

      vim.keymap.set('i', '<C-k>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true, desc = 'Codeium cycle next' })

      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true, desc = 'Codeium clear' })
    end,
  },
  {
    'robitx/gp.nvim',
    config = function()
      local default_chat_system_prompt = 'You are a general AI assistant.\n\n'
        .. 'The user provided the additional info about how they would like you to respond:\n\n'
        .. "- If you're unsure don't guess and say you don't know instead.\n"
        .. '- Ask question if you need clarification to provide better answer.\n'
        .. '- Think deeply and carefully from first principles step by step.\n'
        .. '- Zoom out first to see the big picture and then zoom in to details.\n'
        .. '- Use Socratic method to improve your thinking and coding skills.\n'
        .. "- Don't elide any code from your output if the answer requires coding.\n"
        .. "- Take a deep breath; You've got this!\n"

      local default_code_system_prompt = 'You are an AI working as a code editor.\n\n'
        .. 'Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n'
        .. 'START AND END YOUR ANSWER WITH:\n\n```'

      require('gp').setup {
        openai_api_key = { 'cat', '/Users/jack/.config/openai/openai_api_key.pem' },
        copilot = {
          endpoint = 'https://api.githubcopilot.com/chat/completions',
          secret = {
            'bash',
            '-c',
            "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },

        agents = {
          {
            name = 'ChatGPT4o',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = default_chat_system_prompt,
          },
          {
            provider = 'openai',
            name = 'ChatGPT3-5',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-3.5-turbo', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = default_chat_system_prompt,
          },
          {
            provider = 'copilot',
            name = 'ChatCopilot',
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4', temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = default_chat_system_prompt,
          },
          {
            provider = 'openai',
            name = 'CodeGPT4o',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-4o', temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = default_code_system_prompt,
          },
          {
            provider = 'openai',
            name = 'CodeGPT3-5',
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = 'gpt-3.5-turbo', temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = default_code_system_prompt,
          },
          {
            provider = 'copilot',
            name = 'CodeCopilot',
            chat = false,
            command = true,
            -- string with the Copilot engine name or table with engine name and parameters if applicable
            model = { model = 'gpt-4', temperature = 0.8, top_p = 1, n = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = default_code_system_prompt,
          },
        },
        chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g><C-g>' },
        chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>d' },
        chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>s' },
        chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>c' },
        hooks = {
          Explain = function(gp, params)
            local template = 'I have the following code from {{filename}}:\n\n'
              .. '```{{filetype}}\n{{selection}}\n```\n\n'
              .. 'Please respond by explaining the code above.'
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
          end,
        },
      }
    end,
  },
}
