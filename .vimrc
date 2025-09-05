" ----- Global Settings -----
set ignorecase
set incsearch
set nohlsearch
set noshowcmd
set number
set smartcase
let mapleader=" "
set undodir=~/.vim/undodir
set undofile
set scrolloff=8
set history=300

" ----- Key Mappings -----
" Navigation in insert/command mode
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Search remapping
nnoremap <Space> /
nnoremap <S-Space> ?

" Editing improvements
nnoremap d "_d
xnoremap d "_d
nnoremap r "_r
xnoremap r "_r
xnoremap p P

" ----- Vim-Specific Config -----
if !has('ide')
    colorscheme desert
    filetype plugin indent on
    set autoindent
    set backspace=indent,eol,start
    set fileformat=unix
    set foldlevel=99
    set foldmethod=indent
    set omnifunc=syntaxcomplete#Complete
    set shiftwidth=2
    set softtabstop=2
    set splitbelow
    set splitright
    set textwidth=120
    syntax on
endif

" ----- Plugin Management -----
runtime macros/matchit.vimrc
set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',ё\\,яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё/|
