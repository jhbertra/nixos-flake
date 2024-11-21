{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
  ];
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins;
      let
        vim-textobj-entire = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "vim-textobj-entire";
          src = pkgs.fetchFromGitHub {
            owner = "kana";
            repo = "vim-textobj-entire";
            rev = "64a856c9dff3425ed8a863b9ec0a21dbaee6fb3a";
            sha256 = "0kv0s85wbcxn9hrvml4hdzbpf49b1wwr3nk6gsz3p5rvfs6fbvmm";
          };
        };
        vim-textobj-line = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "vim-textobj-line";
          src = pkgs.fetchFromGitHub {
            owner = "kana";
            repo = "vim-textobj-line";
            rev = "0a78169a33c7ea7718b9fa0fad63c11c04727291";
            sha256 = "0mppgcmb83wpvn33vadk0wq6w6pg9cq37818d1alk6ka0fdj7ack";
          };
        };
        neoformat-latest = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "neoformat";
          src = pkgs.fetchFromGitHub {
            owner = "sbdchd";
            repo = "neoformat";
            rev = "74c91bb4a84b6a2f160af7d3f6785ef980513566";
            sha256 = "0v558p3ixyxw58nrz02627cji93lc3gxq5iw72k70x2i320qfb2y";
          };
        };
      in
      [
        ReplaceWithRegister
        coc-nvim
        colorizer
        fzf-vim
        fzfWrapper
        neoformat-latest
        nord-vim
        polyglot
        targets-vim
        ultisnips
        vim-abolish
        vim-airline
        vim-commentary
        vim-exchange
        vim-indent-object
        vim-projectionist
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
        zig-vim
      ];

    extraConfig = ''
      " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      " UltiSnips
      " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      let g:UltiSnipsExpandTrigger="s<tab>"
      let g:UltiSnipsJumpForwardTrigger="<c-b>"
      let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
      " Coc.nvim
      " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
      set smartindent " dedent / indent new lines based on rules.
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

      " Nord is a beautiful theme
      colorscheme nord
    '';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
