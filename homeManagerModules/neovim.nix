{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.modules.neovim;
in
{
  options = {
    modules.neovim = {
      enable = lib.mkEnableOption "Enables neovim support";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
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
      extraConfig = ''
      '';
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
    };
  };
}
