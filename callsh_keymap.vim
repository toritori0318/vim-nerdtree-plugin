if exists("g:loaded_nerdtree_callsh_keymap")
  finish
endif
let g:loaded_nerdtree_callsh_keymap = 1

if !exists('g:callsh_cmd')
  let g:callsh_cmd = "open -n -a 'iTerm' "  " windows (?)
endif

call NERDTreeAddKeyMap({
    \ 'key': 'sh',
    \ 'callback': 'NERDTreeCallSh',
    \ 'quickhelpText': 'Call Shell Command' })

function! NERDTreeCallSh()
    let currentNode = g:NERDTreeFileNode.GetSelected()
    if currentNode.path.isDirectory
       try
           " open -n -a 'iTerm' --args 'cd dir; #'
           cgetexpr system(g:callsh_cmd . " --args 'cd " . currentNode.path.str() . "; #'")
       catch /^Vim\%((\a\+)\)\=:/
           echo v:exception
       endtry
    else
       call s:echo(currentNode.path.str() . " is Not Directory.")
    endif
endfunction
