if exists("g:loaded_nerdtree_callfinder_keymap")
  finish
endif
let g:loaded_nerdtree_callfinder_keymap = 1
if !exists('g:callfinder_cmd')
  let g:callfinder_cmd = "open"  " mac : open / windows (?)
endif

call NERDTreeAddKeyMap({
    \ 'key': 'fd',
    \ 'callback': 'NERDTreeCallFinder',
    \ 'quickhelpText': 'Call Finder Command' })

function! s:echo(msg)
    redraw
    echomsg "NERDTree: " . a:msg
endfunction

function! NERDTreeCallFinder()
    let currentNode = g:NERDTreeFileNode.GetSelected()
    try
        " open -n -a 'iTerm' --args 'cd dir; #'
        cgetexpr system(g:callfinder_cmd . " " . currentNode.path.str())
    catch /^Vim\%((\a\+)\)\=:/
        echo v:exception
    endtry
endfunction
