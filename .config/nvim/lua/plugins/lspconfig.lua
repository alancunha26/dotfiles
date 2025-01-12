return {
  'neovim/nvim-lspconfig',
  ---@class PluginLspOpts
  opts = {
    servers = {
      'stylua',
      'ts_ls',
      'css_ls',
      'emmet_language_server',
      'html',

      marksman = {
        on_attach = function(client)
          -- Disables marksman autocompletion to use zk completion instead
          client.server_capabilities.completionProvider = false
        end,
      },
    },
  },
}
