NixInfo = require(vim.g.nix_info_plugin_name)
NixConfigRoot = os.getenv("NIX_CONFIG_ROOT")
if NixConfigRoot == nil then
  vim.notify("NIX_CONFIG_ROOT is empty", vim.log.levels.ERROR)
end

require("init")
