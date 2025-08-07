function! plugins#nvim_lsp#load()
lua << EOF
	local lsp_status = require('lsp-status')

	lsp_status.config({
		current_function = false,
		show_filename = false,
		select_symbol = function(cursor_pos, document_symbol)
			return false
		end,
		spinner_frames = {'', '', '', '', ''},
		indicator_errors = '',
		indicator_warnings = '',
		indicator_info = '',
		indicator_hint = '',
		indicator_ok = '',
		update_interval = 100,
	})

	lsp_status.register_progress()

	local mason = require("mason")

	mason.setup({})

	local on_attach = function(client, bufnr)
		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		local opts = { noremap=true, silent=true }

		buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		buf_set_keymap('n', ',r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', '<C-,>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
		buf_set_keymap('n', '<C-m>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

		lsp_status.on_attach(client)
	end

	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
	capabilities.offsetEncoding = { "utf-16" }

	local util = require("lspconfig/util")

	require("flutter-tools").setup {
		ui = {
			border = "none",
		},
		decorations = {
			statusline = {
				app_version = false,
				device = false,
			}
		},
		debugger = {
			enabled = false,
			run_via_dap = false,
		},
		widget_guides = {
			enabled = true,
		},
		closing_tags = {
			highlight = "ClosingTags",
			prefix = " ",
			enabled = true
		},
		dev_log = {
			enabled = true,
			open_cmd = "tabedit",
		},
		dev_tools = {
			autostart = false,
			auto_open_browser = false,
		},
		outline = {
			open_cmd = "30vnew",
			auto_open = false
		},
                flutter_lookup_cmd = "mise where flutter",
		lsp = {
			on_attach = function(client, bufnr)
				vim.cmd [[hi FlutterWidgetGuides ctermfg=237 guifg=#33374c]]
				vim.cmd [[hi ClosingTags ctermfg=244 guifg=#8389a3]]
				on_attach(client, bufnr)
			end,
			capabilities = capabilities,
			settings = {
				showTodos = false,
				completeFunctionCalls = true,
				analysisExcludedFolders = {
					vim.fn.expand("$HOME/.pub-cache"),
					vim.fn.expand("$HOME/fvm"),
				}
			}
		}
	}

	vim.diagnostic.config({
		virtual_text = {
			prefix = '✔︎',
		},
		signs = false,
		underline = false,
	})
EOF

endfunction
