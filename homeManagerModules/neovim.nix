{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.modules.neovim;
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  options = {
    modules.neovim = {
      enable = lib.mkEnableOption "Enables neovim support";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      vimAlias = true;
      viAlias = true;
      globals.mapleader = " ";
      globalOpts = {
        backspace = ["indent" "eol" "start"];
        expandtab = true;
        smarttab = true;
        shiftround = true;
        autoindent = true;
        smartindent = true;
        history = 500;
        ruler = true;
        showcmd = true;
        laststatus = 2;
        autowrite = true;
        list = true;
        # NOTE: .__raw here means that this field is raw lua code
        listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
        wildmenu = true;
        lazyredraw = true;
        ttyfast = true;
        wrap = false;
        errorbells = false;
        visualbell = false;
        undodir = "~/.vim/undo";
        undofile = true;
        undolevels = 10000;
        undoreload = 10000;
        cmdheight = 2;
        updatetime = 300;
        joinspaces = false;
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        mouse = "a";
        cursorline = true;
        numberwidth = 5;
        scrolloff = 5;
        sidescrolloff = 5;
        splitbelow = true;
        splitright = true;
        backup = false;
        writebackup = false;
        swapfile = false;
        hidden = true;
        autoread = true;
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        showmatch = true;
        hlsearch = true;
        gdefault = true;
      };
      keymaps = [
        {
          action = "<c-d>";
          key = "<s-tab>";
          mode = "i";
        }
        {
          action = ":noh<cr>:call clearmatches()<cr>";
          key = "<leader>,";
          mode = "n";
        }
        {
          action = "<c-^>";
          key = "<leader><tab>";
        }
        {
          action = "<cmd>Telescope find_files<cr>";
          key = "<leader>ff";
        }
        {
          action = "<cmd>Telescope live_grep<cr>";
          key = "<leader>fg";
        }
        {
          action = "<cmd>Telescope buffers<cr>";
          key = "<leader>fb";
        }
        {
          action = "<cmd>Telescope old_files<cr>";
          key = "<leader>fh";
        }
        {
          action = "<cmd>Telescope quickfix<cr>";
          key = "<leader>fq";
        }
        {
          action = "<cmd>Telescope loclist<cr>";
          key = "<leader>fl";
        }
        {
          action = "<cmd>Telescope jumplist<cr>";
          key = "<leader>fj";
        }
        {
          action = "<cmd>Telescope lsp_references<cr>";
          key = "<leader>fj";
        }
      ];
      colorschemes.gruvbox.enable = true;
      performance.byteCompileLua.enable = true;
      performance.byteCompileLua.configs = true;
      performance.byteCompileLua.initLua = true;
      performance.byteCompileLua.nvimRuntime = true;
      performance.byteCompileLua.plugins = true;
      plugins = {
        better-escape = {
          enable = true;
          settings.mappings = {
            c = {
              h = {
                h = "<Esc>";
                f = "<Esc>";
              };
            };
            i = {
              h = {
                h = "<Esc>";
                f = "<Esc>";
              };
            };
            s = {
              h = {
                f = "<Esc>";
              };
            };
            t = {
              h = {
                h = "<Esc>";
                f = "<Esc>";
              };
            };
            v = {
              h = {
                f = "<Esc>";
              };
            };
          };
        };
        cmp = {
          enable = true;
          settings = {
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
            sources = [
              {
                name = "nvim_lsp";
              }
              {
                name = "nvim_lsp_signature_help";
              }
              {
                name = "luasnip";
              }
              {
                name = "path";
              }
              {
                name = "buffer";
              }
              {
                name = "look";
              }
              {
                name = "path";
              }
            ];
          };
        };
        comment.enable = true;
        committia.enable = true;
        diffview.enable = true;
        dressing.enable = true;
        fastaction.enable = true;
        firenvim.enable = true;
        git-conflict.enable = true;
        gitblame.enable = true;
        gitgutter.enable = true;
        gitignore.enable = true;
        gitlinker.enable = true;
        gitmessenger.enable = true;
        hardtime.enable = true;
        headlines.enable = true;
        hex.enable = true;
        lastplace.enable = true;
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            typos_lsp.enable = true;
            zk.enable = true;
          };
        };
        lsp-format.enable = true;
        lsp-lines.enable = true;
        lsp-signature.enable = true;
        lsp-status.enable = true;
        lualine.enable = true;
        mark-radar.enable = true;
        markview.enable = true;
        neoclip.enable = true;
        neorg.enable = true;
        neorg.telescopeIntegration.enable = true;
        neotest.enable = true;
        nix.enable = true;
        nix-develop.enable = true;
        nvim-autopairs.enable = true;
        nvim-jdtls = {
          enable = true;
          data = "/home/jamie/.cache/jdtls/workspace";
          configuration = "/home/jamie/.cache/jdtls/config";
        };
        oil.enable = true;
        refactoring.enable = true;
        repeat.enable = true;
        sandwich.enable = true;
        sleuth.enable = true;
        spectre.enable = true;
        spider.enable = true;
        telekasten.enable = true;
        telescope.enable = true;
        todo-comments.enable = true;
        toggleterm.enable = true;
        treesitter.enable = true;
        treesitter-textobjects.enable = true;
        trim.enable = true;
        trouble.enable = true;
        typescript-tools.enable = true;
        undotree.enable = true;
        vim-dadbod.enable = true;
        vim-dadbod-completion.enable = true;
        web-devicons.enable = true;
        which-key.enable = true;
        wilder.enable = true;
      };
    };
    programs.neovim = {
      enable = false;
      coc = {
        enable = true;
        pluginConfig = ''
          inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ CheckBackspace() ? "\<TAB>" :
                \ coc#refresh()
          inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

          function! CheckBackspace() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
          endfunction

          inoremap <silent><expr> <c-space> coc#refresh()

          inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

          nmap <silent> [g <Plug>(coc-diagnostic-prev)
          nmap <silent> ]g <Plug>(coc-diagnostic-next)

          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gt <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)

          nnoremap <silent> K :call <SID>show_documentation()<CR>

          function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
              execute 'h '.expand('<cword>')
            elseif (coc#rpc#ready())
              call CocActionAsync('doHover')
            else
              execute '!' . &keywordprg . " " . expand('<cword>')
            endif
          endfunction

          autocmd CursorHold * silent call CocActionAsync('highlight')

          nmap <leader>rn <Plug>(coc-rename)

          xmap <leader>a  <Plug>(coc-codeaction-selected)
          nmap <leader>a  <Plug>(coc-codeaction-selected)
          nmap <leader>ac  <Plug>(coc-codeaction)
          nmap <leader>qf  <Plug>(coc-fix-current)
          xmap if <Plug>(coc-funcobj-i)
          omap if <Plug>(coc-funcobj-i)
          xmap af <Plug>(coc-funcobj-a)
          omap af <Plug>(coc-funcobj-a)
          xmap ic <Plug>(coc-classobj-i)
          omap ic <Plug>(coc-classobj-i)
          xmap ac <Plug>(coc-classobj-a)
          omap ac <Plug>(coc-classobj-a)

          nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
          vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
          vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"

          nmap <silent> <C-s> <Plug>(coc-range-select)
          xmap <silent> <C-s> <Plug>(coc-range-select)

          command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
          nnoremap <leader>o :OrganizeImports<cr>
        '';
        settings = { };
      };
      defaultEditor = true;
      extraPackages = [
      ];
      plugins = with pkgs.vimPlugins;
        let
          vim-textobj-entire = pkgs.vimUtils.buildVimPlugin {
            name = "vim-textobj-entire";
            src = inputs.vim-textobj-entire;
          };
          vim-textobj-line = pkgs.vimUtils.buildVimPlugin {
            name = "vim-textobj-line";
            src = inputs.vim-textobj-line;
          };
        in
        [
          ReplaceWithRegister
          colorizer
          fzf-vim
          fzfWrapper
          neoformat
          gruvbox-nvim
          polyglot
          targets-vim
          vim-abolish
          vim-airline
          vim-commentary
          vim-exchange
          vim-indent-object
          vim-repeat
          vim-sensible
          vim-sleuth
          vim-sort-motion
          vim-surround
          vim-textobj-entire
          vim-textobj-line
          vim-textobj-user
          vim-unimpaired
          {
            plugin = toggleterm-nvim;
            config = ''
              lua << EOF
              require("toggleterm").setup{
                size = function(term)
                  if term.direction == "horizontal" then
                    return 15
                  elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                  end
                end,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                start_in_insert = true,
                insert_mappings = true,
                terminal_mappings = true,
                persist_size = true,
                direction = 'float',
                close_on_exit = true,
                float_opts = {
                  border = 'single',
                  highlights = {
                    border = 'Normal',
                    background = 'Normal',
                  }
                }
              }
              EOF
            '';
          }
        ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraConfig = ''
        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        " Fuzzy Search
        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        nnoremap <Leader>p :GFiles --exclude-standard --others --cached<CR>
        nnoremap <leader>h :History<CR>
        nnoremap <Leader>F :Lines<CR>

        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        " Airline
        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        let g:airline_powerline_fonts = 1

        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif

        " unicode symbols
        let g:airline_left_sep = '»'
        let g:airline_left_sep = '▶'
        let g:airline_right_sep = '«'
        let g:airline_right_sep = '◀'
        let g:airline_symbols.linenr = '␊'
        let g:airline_symbols.linenr = '␤'
        let g:airline_symbols.linenr = '¶'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.paste = 'ρ'
        let g:airline_symbols.paste = 'Þ'
        let g:airline_symbols.paste = '∥'
        let g:airline_symbols.whitespace = 'Ξ'

        " airline symbols
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.readonly = ''
        let g:airline_symbols.linenr = ''

        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        " Keybindings
        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        " Stop CSV mappings from ruining everything
        let g:csv_nomap_space = 1

        " ESC in terminal mode
        tnoremap hf <C-\><C-n>

        " Moving lines
        nnoremap <Leader>j :m .+1<CR>==
        nnoremap <Leader>k :m .-2<CR>==
        vnoremap <Leader>k :m '<-2<CR>gv=gv
        vnoremap <Leader>j :m '>+1<CR>gv=gv

        " Tabbing in insert mode
        inoremap <s-tab> <c-d>

        " Duplicate line
        nnoremap <Leader>d Yp

        " break some bad habits
        nnoremap <Left> :echoe "Use h"<CR>
        nnoremap <Right> :echoe "Use l"<CR>
        nnoremap <Up> :echoe "Use k"<CR>
        nnoremap <Down> :echoe "Use j"<CR>

        nnoremap <leader>b i<cr><esc><s-o>

        " So we don't have to reach for escape to leave insert mode.
        inoremap hf <esc>

        " Clear match highlighting
        noremap <leader>, :noh<cr>:call clearmatches()<cr>

        " Quick buffer switching - like cmd-tab'ing
        nnoremap <leader><tab> <c-^>

        " Map the key for toggling comments with vim-commentary
        nnoremap <leader>c :Commentary<CR>

        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        " Neoformat
        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        let g:neoformat_enabled_purescript = ['purstidy']

        let g:neoformat_haskell_fourmolu = { 'exe': 'fourmolu' }

        let g:neoformat_enabled_haskell = ['fourmolu']

        let g:neoformat_enabled_zig = ['zig fmt']

        xmap <leader>f  :Neoformat<CR>
        nmap <leader>f  :Neoformat<CR>

        augroup fmt
          autocmd!
          au BufWritePre * try | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
        augroup END

        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        " General Editor Config
        " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        syntax on
        set backspace=indent,eol,start
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set expandtab " use spaces instead of tabs.
        set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
        set shiftround " tab / shifting moves to closest tabstop.
        set autoindent " Match indents on new lines.
        set smartindent " Intelligently dedent / indent new lines based on rules.
        set history=500
        set ruler
        set showcmd
        set laststatus=2
        set autowrite
        set list listchars=tab:»·,trail:·,nbsp:·
        set wildmenu
        set wildmode=list:longest,list:full
        set lazyredraw
        set ttyfast
        set nowrap
        set wrap!
        set noerrorbells novisualbell
        set showcmd
        set undodir=~/.vim/undo/
        set undofile
        set undolevels=1000
        set undoreload=10000
        set cmdheight=2
        set updatetime=300
        set shortmess+=c

        set wildignore+=*/tmp/*
        set wildignore+=*.so
        set wildignore+=*.zip
        set wildignore+=*/vendor/bundle/*
        set wildignore+=*/node_modules/

        " Use one space, not two, after punctuation.
        set nojoinspaces

        " Numbers
        set number
        set numberwidth=5

        set scrolloff=5
        set sidescrolloff=10

        highlight Comment cterm=italic gui=italic

        " Make it obvious where 80 characters is
        set textwidth=79
        set colorcolumn=+1

        " Set defaults for new panes
        set splitbelow
        set splitright

        " We have VCS -- we don't need this stuff.
        set nobackup " We have vcs, we don't need backups.
        set nowritebackup " We have vcs, we don't need backups.
        set noswapfile " They're just annoying. Who likes them?

        " don't nag me when hiding buffers
        set hidden " allow me to have buffers with unsaved changes.
        set autoread " when a file has changed on disk, just load it. Don't ask.


        " Notification after file change
        " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
        autocmd FileChangedShellPost *
          \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

        " Make search more sane
        set ignorecase " case insensitive search
        set smartcase " If there are uppercase letters, become case-sensitive.
        set incsearch " live incremental searching
        set showmatch " live match highlighting
        set hlsearch " highlight matches
        set gdefault " use the `g` flag by default.

        " allow the cursor to go anywhere in visual block mode.
        set virtualedit+=block

        " leader is a key that allows you to have your own "namespace" of keybindings.
        map <space> <Leader>

        colorscheme gruvbox
      '';
    };
  };
}
