" ============================================================================
" File:        python-unittest-helper.vim
" Description: vim global plugin to put the path for lazy unittest authors
"              puts "file.class.function" into system clip board
" Maintainer:  David Szotten <full name as one word@gmail.com>
" License:     MIT
" Notes:       First attempt at a vim plugin, be nice please
"
" ============================================================================



nnoremap <leader>u :<C-U>call <SID>IdentyfyTest()<cr>

function! s:IdentyfyTest()
    let saved_unnamed_register = @@

    " mark current position
    normal! mq

    " goto first on-screen line and mark
    normal! Hmw

    " go back to current position for search
    normal! `q

    execute "normal! ?^    def test_\<cr>"
    :nohlsearch
    normal! wwvey
    let func = @@

    execute "normal! ?^class\<cr>"
    :nohlsearch
    normal! wvey
    let klass = @@

    let file =  expand('%:t')

    " assign result to system clipboard
    let @* = join([file, klass, func], ".")
    echo @*

    " goto previous first on-screen line and restore
    normal! `wzt
    " restore cursor position
    normal! `q

    let @@ = saved_unnamed_register
endfunction
