if exists("g:loaded_nerdtree_callex_keymap")
  finish
endif
let g:loaded_nerdtree_callex_keymap = 1

if !exists('g:callex_cmd')
  let g:callex_cmd = 'open' " mac : open / windows : start (?)
endif

call NERDTreeAddKeyMap({
    \ 'key': 'ca',
    \ 'callback': 'NERDTreeCallEx',
    \ 'quickhelpText': 'Call External Command' })

function! s:echo(msg)
    redraw
    echomsg "NERDTree: " . a:msg
endfunction

function! NERDTreeCallEx()
    let currentNode = g:NERDTreeFileNode.GetSelected()
    if currentNode.path.isDirectory
        call s:echo(currentNode.path.str() . " is Directory.")
    else
       try
           cgetexpr system(g:callex_cmd . " " . currentNode.path.str())
       catch /^Vim\%((\a\+)\)\=:/
           echo v:exception
       endtry
    endif
endfunction
