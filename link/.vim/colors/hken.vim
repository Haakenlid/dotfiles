" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"
"
hi clear

" Support for 256-color terminal
"
hi Normal             ctermfg=253   ctermbg=232
hi Comment            ctermfg=248   ctermbg=235
hi CursorLine                       ctermbg=234   cterm=none
" hi CursorLine                       ctermbg=16    cterm=reverse
hi CursorLineNr       ctermfg=015   ctermbg=none  cterm=bold
hi LineNr             ctermfg=244   ctermbg=233
hi Search             ctermfg=none  ctermbg=none  cterm=reverse
" Brackets and parenthesis
hi Delimiter          ctermfg=243                 cterm=none
" Matchin parenthesis
hi MatchParen         ctermfg=155   ctermbg=240   cterm=bold
hi Operator           ctermfg=39

" Doesn't do anything in xfce-4 terminal
" hi Cursor             ctermfg=16    ctermbg=24

hi Boolean            ctermfg=135
hi Character          ctermfg=144
hi Number             ctermfg=135
hi String             ctermfg=144
hi Conditional        ctermfg=161                 cterm=bold
hi Constant           ctermfg=135                 cterm=bold
hi Debug              ctermfg=225                 cterm=bold
hi Define             ctermfg=81

hi DiffAdd                          ctermbg=24
hi DiffChange         ctermfg=181   ctermbg=239
hi DiffDelete         ctermfg=162   ctermbg=53
hi DiffText                         ctermbg=102   cterm=bold

hi Directory          ctermfg=118                 cterm=bold
hi Error              ctermfg=219   ctermbg=89
hi ErrorMsg           ctermfg=199   ctermbg=16    cterm=bold
hi Exception          ctermfg=118                 cterm=bold
hi Float              ctermfg=135
hi FoldColumn         ctermfg=67    ctermbg=16
hi Folded             ctermfg=67    ctermbg=16
hi Function           ctermfg=118
hi Identifier         ctermfg=208                 cterm=none
hi Ignore             ctermfg=244   ctermbg=232
hi IncSearch          ctermfg=193   ctermbg=16

hi keyword            ctermfg=161                 cterm=bold
hi Label              ctermfg=229                 cterm=none
hi Macro              ctermfg=193
hi SpecialKey         ctermfg=81

hi ModeMsg            ctermfg=229
hi MoreMsg            ctermfg=229

" jsx / xml
hi jsVariableDef      ctermfg=15                cterm=bold
hi jsObjectProp       ctermfg=250
hi xmlTag             ctermfg=226                 cterm=bold
hi xmlTagName         ctermfg=220                 cterm=none
hi xmlEndTag          ctermfg=196
hi xmlString          ctermfg=144

" hi xmlAttrib          ctermfg=75
hi jsObject           ctermfg=207
hi jsObjectKey        ctermfg=207
hi jsObjectBraces     ctermfg=207                 cterm=bold

hi jsBraces           ctermfg=226
hi xmlEqual           ctermfg=226

hi jsImport           ctermfg=39                  cterm=none
hi jsExport           ctermfg=39                  cterm=none
hi jsStorageClass     ctermfg=39                  cterm=none

" complete menu
hi Pmenu              ctermfg=81    ctermbg=16
hi PmenuSel           ctermfg=255   ctermbg=242
hi PmenuSbar                        ctermbg=232
hi PmenuThumb         ctermfg=81

hi PreCondit          ctermfg=118                 cterm=bold
hi PreProc            ctermfg=118
hi Question           ctermfg=81
hi Repeat             ctermfg=161                 cterm=bold

"
hi SignColumn         ctermfg=118   ctermbg=235
hi SpecialChar        ctermfg=161                 cterm=bold
hi SpecialComment     ctermfg=245                 cterm=bold
hi Special            ctermfg=81

" spelling
if has("spell")
  hi SpellBad                       ctermbg=52
  hi SpellCap                       ctermbg=17
  hi SpellLocal                     ctermbg=17
  hi SpellRare        ctermfg=none  ctermbg=none  cterm=reverse
endif
hi Statement          ctermfg=161                 cterm=bold
hi StatusLine         ctermfg=238   ctermbg=253
hi StatusLineNC       ctermfg=244   ctermbg=232
hi StorageClass       ctermfg=208
hi Structure          ctermfg=81
hi Tag                ctermfg=161
hi Title              ctermfg=166
hi Todo               ctermfg=231   ctermbg=232   cterm=bold

hi Typedef            ctermfg=81
hi Type               ctermfg=81                  cterm=none
hi Underlined         ctermfg=244                 cterm=underline

hi VertSplit          ctermfg=244   ctermbg=232   cterm=bold
hi VisualNOS                        ctermbg=238
hi Visual                           ctermbg=235
hi WarningMsg         ctermfg=231   ctermbg=238   cterm=bold
hi WildMenu           ctermfg=81    ctermbg=16

hi CursorColumn                     ctermbg=235
hi ColorColumn                      ctermbg=233
hi NonText            ctermfg=59
hi SpecialKey         ctermfg=59
