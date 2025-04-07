"{{{ Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
filetype indent on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set cindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2
set tabstop=2
set cino=(2
let &colorcolumn=join(range(81,999),",")

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel

" Favorite Color Scheme
if has("gui_running")
   colorscheme nuvola
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   "set guifont=Terminus\ 9
"else
   "colorscheme desert256
endif

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

"}}}



"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}





"}}}

"{{{ Mappings


" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

"}}}


filetype plugin indent on
syntax on
:noremap <2-LeftMouse> *
:inoremap <2-LeftMouse> <c-o>*

hi Search guibg=Orange
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Open = 1
let Tlist_Auto_Update = 1
let Tlist_Auto_Highlight_Tag = 1
"" let Tlist_Use_Right_Window = 1
let Tlist_Display_Tag_Scope = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 47

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set clipboard=unnamedplus

let mapleader=","

:vnoremap p "_dP
:nnoremap <PageUp> <C-U>
:nnoremap <PageDown> <C-D>

set guioptions-=L
set guioptions-=l

:cscope add /home/alek/vim_specific/cscope.out

set tags=./tags;/,tags;/

autocmd BufRead,BufNewFile *.launch setfiletype roslaunch

:set title titlestring=%<%f\ %([%{Tlist_Get_Tagname_By_Line()}]%)

let g:clang_user_options='|| exit 0'

execute pathogen#infect()

let g:NERDTreeWinPos = "right"
"autocmd vimenter * NERDTree

let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc, sfr:../../include,sfr:../../src,sfr:../../src/depth_node,sfr:../../src/hole_fusion_node,sfr:../../src/message_conversions,sfr:../../src/synchronizer_node,sfr:../../src/rgb_node,sfr:../../src/utils,sfr:../../include/depth_node,sfr:../../include/hole_fusion_node,sfr:../../include/message_conversions,sfr:../../include/synchronizer_node,sfr:../../include/rgb_node,sfr:../../include/utils'



au FileType cpp FoldMatching #ifdef #endif 0
au FileType cpp FoldMatching #if #endif 0
set foldmarker=#if,#endif

" Disable additional comments generation
autocmd FileType * setlocal formatoptions-=o

" Latex
set grepprg=grep\ -nH\ $*

" Startup window size
:set lines=65 columns=84


:setlocal spell spelllang=en_us


" copy-paste in insert mode
set pastetoggle=<F10>
inoremap <C-v> <F10><C-r>+<F10>
set clipboard=unnamedplus


" python-specific settings
augroup python_files
    autocmd!
    autocmd FileType python setlocal expandtab
    autocmd FileType python set tabstop=2
    autocmd FileType python set shiftwidth=2
augroup END

nmap <F4> :call SVED_Sync()<CR>

augroup debianlatexfix
  " Remove all vimrc autocommands within scope
  autocmd!
  autocmd BufNewFile,BufRead *.tex   set syntax=tex
  autocmd BufNewFile,BufRead *.tex   set filetype=tex
  autocmd BufNewFile,BufRead *.cls   set syntax=tex
augroup END

autocmd FileType text setlocal nocindent
autocmd FileType tex setlocal nocindent

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>
imap <C-Del> <Esc>lce

" This unsets the last search pattern register by hitting return
"nnoremap <CR> :noh<CR><CR>

" Highlight the word under the cursor like *, but do not move the cursor.
" Then map * to left-click
" https://stackoverflow.com/questions/6876850/how-to-highlight-all-occurrences-of-a-word-in-vim-on-double-clicking
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
:map * <2-LeftMouse>

" Hybril line numbers in normal mode, absolute number lines in insert mode
" https://jeffkreeftmeijer.com/vim-number/
:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END
