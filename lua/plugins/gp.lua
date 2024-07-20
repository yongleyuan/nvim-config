return {
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
      providers = {
        copilot = {
          endpoint = 'https://api.githubcopilot.com/chat/completions',
          secret = {
            'bash',
            '-c',
            "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },
      },
      agents = {
        {
          name = 'ChatGPT4o',
          provider = 'openai',
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = 'gpt-4o', temperature = 1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = default_chat_system_prompt,
        },
        {
          name = 'ChatGPT3-5',
          provider = 'openai',
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = 'gpt-3.5-turbo', temperature = 1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = default_chat_system_prompt,
        },
        {
          provider = 'copilot',
          name = 'ChatCopilot',
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = 'gpt-4', temperature = 1, top_p = 1 },
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
          model = { model = 'gpt-4', temperature = 0.8, top_p = 1 },
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
}
