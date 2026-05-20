return {
  {
    'gopls',
    lsp = {
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          env = {
            GOFUMPT_SPLIT_LONG_LINES = 'on',
          },
          hints = {
            assignVariableTypes = false,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = false,
            parameterNames = false,
            rangeVariableTypes = false,
          },
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = false,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = {
            '-.git',
            '-.devenv',
            '-.direnv',
            '-**/.devenv',
            '-**/.direnv',
            '-tmp',
            '-**/tmp',
            '-.vscode',
            '-.idea',
            '-.vscode-test',
            '-node_modules',
            '-**/node_modules',
          },
          semanticTokens = true,
        },
      },
    },
  },
}
