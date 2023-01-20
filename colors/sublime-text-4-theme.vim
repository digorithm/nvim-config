
" If you are distributing this theme, please replace this comment
" with the appropriate license attributing the original VS Code
" theme author.


" Sublime Text 4 Theme - A nice dark theme

" ==========> Reset
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = 'sublime-text-4-theme'

" ==========> Highlight function
function! s:h(face, guibg, guifg, ctermbg, ctermfg, gui)
  let l:cmd="highlight " . a:face
  
  if a:guibg != ""
    let l:cmd = l:cmd . " guibg=" . a:guibg
  endif

  if a:guifg != ""
    let l:cmd = l:cmd . " guifg=" . a:guifg
  endif

  if a:ctermbg != ""
    let l:cmd = l:cmd . " ctermbg=" . a:ctermbg
  endif

  if a:ctermfg != ""
    let l:cmd = l:cmd . " ctermfg=" . a:ctermfg
  endif

  if a:gui != ""
    let l:cmd = l:cmd . " gui=" . a:gui
  endif

  exec l:cmd
endfun


" ==========> Colors dictionary

" GUI colors dictionary (hex)
let s:hex = {}
" Terminal colors dictionary (256)
let s:bit = {}


let s:hex.color0="#303841"
let s:hex.color1="#d8dee9"
let s:hex.color2="#f9ae58"
let s:hex.color3="#4c5863"
let s:hex.color4="#3a424b"
let s:hex.color5="#626a73"
let s:hex.color6="#444c55"
let s:hex.color7="#767e87"
let s:hex.color8="#42464c"
let s:hex.color9="#fafafa"
let s:hex.color10="#5b5f65"
let s:hex.color11="#ffffff"
let s:hex.color12="#7b838c"
let s:hex.color13="#4ba0a0"
let s:hex.color14="#4e565f"
let s:hex.color15="#f6fcff"
let s:hex.color16="#e2e8f3"
let s:hex.color17="#535b64"
let s:hex.color18="#A6ACB9"
let s:hex.color19="#EC5F66"
let s:hex.color20="#5FB4B4"
let s:hex.color21="#C695C6"
let s:hex.color22="#F97B58"
let s:hex.color23="#99C794"
let s:hex.color24="#F9AE58"


let s:bit.color9="59"
let s:bit.color10="73"
let s:bit.color16="114"
let s:bit.color12="145"
let s:bit.color14="176"
let s:bit.color13="203"
let s:bit.color15="209"
let s:bit.color2="215"
let s:bit.color8="231"
let s:bit.color0="237"
let s:bit.color4="238"
let s:bit.color6="239"
let s:bit.color3="240"
let s:bit.color5="242"
let s:bit.color7="244"
let s:bit.color1="254"
let s:bit.color11="255"



" ==========> General highlights 
call s:h("Normal", s:hex.color0, s:hex.color1, s:bit.color0, s:bit.color1, "none")
call s:h("Cursor", s:hex.color2, "", s:bit.color2, "", "none")
call s:h("Visual", s:hex.color3, "", s:bit.color3, "", "none")
call s:h("ColorColumn", s:hex.color4, "", s:bit.color4, "", "none")
call s:h("LineNr", "", s:hex.color5, "", s:bit.color5, "none")
call s:h("CursorLine", s:hex.color6, "", s:bit.color6, "", "none")
call s:h("CursorLineNr", "", s:hex.color7, "", s:bit.color7, "none")
call s:h("CursorColumn", s:hex.color6, "", s:bit.color6, "", "none")
call s:h("StatusLineNC", s:hex.color8, s:hex.color9, s:bit.color4, s:bit.color8, "none")
call s:h("StatusLine", s:hex.color10, s:hex.color11, s:bit.color9, s:bit.color8, "none")
call s:h("VertSplit", "", s:hex.color12, "", s:bit.color7, "none")
call s:h("Folded", s:hex.color6, s:hex.color13, s:bit.color6, s:bit.color10, "none")
call s:h("Pmenu", s:hex.color14, s:hex.color15, s:bit.color3, s:bit.color8, "none")
call s:h("PmenuSel", s:hex.color4, s:hex.color16, s:bit.color4, s:bit.color11, "none")
call s:h("EndOfBuffer", s:hex.color0, s:hex.color17, s:bit.color0, s:bit.color3, "none")
call s:h("NonText", s:hex.color0, s:hex.color17, s:bit.color0, s:bit.color3, "none")


" ==========> Syntax highlights
call s:h("Comment", "", s:hex.color18, "", s:bit.color12, "none")
call s:h("Constant", "", s:hex.color19, "", s:bit.color13, "none")
call s:h("Special", "", s:hex.color19, "", s:bit.color13, "none")
call s:h("Function", "", s:hex.color20, "", s:bit.color10, "none")
call s:h("Statement", "", s:hex.color21, "", s:bit.color14, "none")
call s:h("Operator", "", s:hex.color22, "", s:bit.color15, "none")
call s:h("PreProc", "", s:hex.color21, "", s:bit.color14, "none")
call s:h("Type", "", s:hex.color21, "", s:bit.color14, "none")
call s:h("String", "", s:hex.color23, "", s:bit.color16, "none")
call s:h("Number", "", s:hex.color24, "", s:bit.color2, "none")

highlight link cStatement Statement
highlight link cSpecial Special


" Generated using https://github.com/nice/themeforge
" Feel free to remove the above URL and this line.
