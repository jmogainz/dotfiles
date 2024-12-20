require('avante_lib').load()
require('avante').setup({
  provider = 'claude',
  claude = {
    endpoint = 'https://api.anthropic.com',
    model = 'claude-3-5-sonnet-20241022',  -- Specify the desired model here
    temperature = 0,
    max_tokens = 4096,
  },
})

