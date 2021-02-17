nnoremap <F1> :CocCommand<CR>
set modeline
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal formatoptions=croql
setlocal foldnestmax=2

" Allows quick debugging
function! DebugNearest()
    let g:test#custom_runners = {'python': ['pudb']}
    let g:test#python#runner = 'pudb'
    TestNearest
    unlet g:test#custom_runners
    unlet g:test#python#runner
endfunction

nmap <silent> t<C-d> :call DebugNearest()<CR>

" Black: Run on Autosave and on Leader+P
nnoremap <Leader>p :Black<CR>

" Vim-Slime: Automatically save then run file in jupyter console or ipython
nnoremap <Leader>r :w<CR> :execute 'SlimeSend1 %run' expand('%:p')<CR>
