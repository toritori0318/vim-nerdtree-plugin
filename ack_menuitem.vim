if exists("g:loaded_nerdtree_ack")
  finish
endif
let g:loaded_nerdtree_ack = 1

if !exists('g:ack_cmd')
  let g:ack_cmd = 'ack' " Debian's package ack name is ack-grep.
endif

if !exists('g:ack_open_wincmd')
  let g:ack_open_wincmd = 'cwin'
end

call NERDTreeAddMenuItem({'text': '(g)rep directory', 'shortcut': 'g', 'callback': 'NERDTreeAck'})



function! NERDTreeAck()
    let curDirNode = g:NERDTreeDirNode.GetSelected()

    let word_and_option = input("Execute Ack\n".
                          \ "==========================================================\n".
                          \ "Current Dir. (".curDirNode.path.str({'format': 'Glob'}).")\n" .
                          \ "Enter the search word (and option)\n" .
                          \ "")

    if word_and_option ==# ''
        call s:echo("Ack Aborted.")
        return
    endif

    let args  = [g:ack_cmd]
    let args += split(word_and_option, ' ')
    let args += ['--nocolor', '--nogroup']
    let args += [curDirNode.path.str()]

    "echomsg join(args,' ')
    cgetexpr system(join(args, ' '))
    silent exec g:ack_open_wincmd
endfunction


