" ========================================
" PLUGINS
" ========================================

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'                         " file navigation
Plug 'Xuyuanp/nerdtree-git-plugin'                 " shows git status in NERDTree
Plug 'airblade/vim-gitgutter'                      " git diff in gutter
Plug 'ctrlpvim/ctrlp.vim'                          " fuzzy file search
Plug 'easymotion/vim-easymotion'                   " moving around files with greater speed
Plug 'scrooloose/nerdcommenter'                    " easier commenting
Plug 'ap/vim-css-color'                            " color previews
Plug 'dyng/ctrlsf.vim'                             " Sublime-like find in files
Plug 'junegunn/vim-slash'                          " improved searching
Plug 'machakann/vim-sandwich'                      " surroundings
Plug 'itchyny/lightline.vim'                       " nicer statusline
Plug 'christoomey/vim-tmux-navigator'              " better tmux/vim navigation
Plug 'w0rp/ale'                                    " async linting
Plug 'sheerun/vim-polyglot'                        " collection of language packs
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colorschemes
Plug 'morhetz/gruvbox'

call plug#end()


" ========================================
" GENERAL CONFIG
" ========================================

set autoindent
set backspace=2                                    " allows backspacing
set wildmenu                                       " tab completion of menu commands
set incsearch                                      " jump to search match while typing
set list listchars=eol:¬,tab:▸\ ,trail:·           " show invisible chars
set number relativenumber                          " shows line numbers
set shiftwidth=2                                   " number of spaces for indents
set tabstop=2                                      " size of tab character in spaces
set softtabstop=2                                  " number of spaces for tab in insert mode
set expandtab                                      " tabs become spaces
set updatetime=750                                 " 750ms update time
set fillchars+=vert:\                              " statusline and vertsplit fillchars
set cursorline                                     " highlights active line
set laststatus=2                                   " always show status line
set clipboard=unnamed                              " copy+pasta to and from system clipboard
set hlsearch                                       " highlight all matching search terms
set mouse=a                                        " can use mouse to scroll and select
set termguicolors                                  " truecolor
set iskeyword+=-                                   " what should not be considered a word boundary
set noshowmode                                     " remove mode information from last line
set lazyredraw                                     " makes vim faster

let &colorcolumn='80,'.join(range(120,373),',')    " colorcolumn at line 80 and 120+

" changes the cursor shape depending on the mode
if exists('$TMUX')
  let &t_SI="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
else
  let &t_SI="\<Esc>]50;CursorShape=1\x7"
  let &t_EI="\<Esc>]50;CursorShape=0\x7"
  let &t_SR="\<Esc>]50;CursorShape=2\x7"
endif

filetype plugin indent on                          " filetype detect and indent

set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox


" ========================================
" KEYMAPS
" ========================================

" make Y do what C and D do
noremap  Y       y$
" switching windows/panes
noremap  <Tab>   <c-w>w
noremap  <BS>    <c-w>W
" opening loclist automatically
nnoremap :b :ls<CR>:b<Space>

" command aliases for lazy shift finger
command! -bar -nargs=* -complete=file -range=% -bang W <line1>,<line2>write<bang> <args>
command! -bar                                  -bang Q quit<bang>
command! -bar -nargs=* -complete=file          -bang E edit<bang> <args>


" ========================================
" PLUGIN SPECIFIC
" ========================================

" nerdtree ===============================
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.swp$', '\.DS_Store']
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" ctrlsf =================================
nmap <Leader>ff <Plug>CtrlSFPrompt
vmap <Leader>ff <Plug>CtrlSFVwordPath
vmap <Leader>fF <Plug>CtrlSFVwordExec
nmap <Leader>fn <Plug>CtrlSFCwordPath
let g:ctrlsf_mapping={
  \ 'vsplit': '<Space>'
  \ }

" ctrlp.vim ==============================
let g:ctrlp_custom_ignore='\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_map='<leader>t'

" nerdcommenter ==========================
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" lightline.vim ==========================
let g:lightline={
  \ 'colorscheme': 'gruvbox'
  \ }

" vim-polyglot ===========================
let g:polyglot_disabled=['graphql']
let g:javascript_plugin_jsdoc=1

" ale ====================================
let g:ale_lint_on_enter=1
let g:ale_echo_msg_format='[%linter%] %s'

" coc.nvim ===============================
command! -nargs=0 Prettier :CocCommand prettier.formatFile
