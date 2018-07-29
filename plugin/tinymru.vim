" tinymru.vim - A tiny MRU plugin
" Maintainer:	romainl <romainlafourcade@gmail.com>
" Version:	0.0.1
" License:	MIT
" Location:	plugin/tinymru.vim
" Website:	https://github.com/romainl/vim-tinyMRU

if exists("g:loaded_tinymru") || v:version < 703 || &compatible
  finish
endif
let g:loaded_tinymru = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:IsReadable(idx, val)
    return filereadable(expand(a:val))
endfunction

" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
    let l:readables = filter(copy(v:oldfiles), function('s:IsReadable'))
    return filter(l:readables, 'v:val =~ a:ArgLead')
endfunction

" MRU function
function! s:MRU(command, arg)
    if a:command == "tabedit"
        execute a:command . " " . a:arg . "\|lcd %:p:h"
    else
        execute a:command . " " . a:arg
    endif
endfunction

" commands
command! -nargs=1 -complete=customlist,<sid>MRUComplete ME call <sid>MRU('edit', fnameescape(<f-args>))
command! -nargs=1 -complete=customlist,<sid>MRUComplete MS call <sid>MRU('split', fnameescape(<f-args>))
command! -nargs=1 -complete=customlist,<sid>MRUComplete MV call <sid>MRU('vsplit', fnameescape(<f-args>))
command! -nargs=1 -complete=customlist,<sid>MRUComplete MT call <sid>MRU('tabedit', fnameescape(<f-args>))

let &cpo = s:save_cpo
