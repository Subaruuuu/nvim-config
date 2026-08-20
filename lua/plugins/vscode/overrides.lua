-- VSCode-only plugins.
--
-- Nothing lives here yet: flash, accelerated-jk and treesitter are shared and sit
-- in `plugins/common/`. This file still has to exist -- `{ import = "plugins.vscode" }`
-- errors out if the directory has no Lua module to import.
return {}
