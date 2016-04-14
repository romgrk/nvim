
setlocal omnifunc=necoghc#omnifunc

let s:width = 80

function! HaskellModuleSection(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Section name: ")
    return  repeat('-', s:width) . "\n"
    \       . "--  " . name . "\n"
    \       . "\n"
endfunction
function! HaskellModuleHeader(...)
    let name = 0 < a:0 ? a:1 : inputdialog("Module: ")
    let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
    let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")
    return  repeat('-', s:width) . "\n"
    \       . "-- | \n"
    \       . "-- Module      : " . name . "\n"
    \       . "-- Note        : " . note . "\n"
    \       . "-- \n"
    \       . "-- " . description . "\n"
    \       . "-- \n"
    \       . repeat('-', s:width) . "\n"
    \       . "\n"
endfunction

nnoremap <buffer><silent> --h "=HaskellModuleHeader()<CR>:0put =<CR>
nnoremap <buffer><silent> --s "=HaskellModuleSection()<CR>p

map <buffer><silent> =tw :GhcModTypeInsert<CR>
map <buffer><silent> =ts :GhcModSplitFunCase<CR>
map <buffer><silent> =tq :GhcModType<CR>
map <buffer><silent> =te :GhcModTypeClear<CR>

nmap <buffer> ga- vip:EasyAlign /->/<CR>
nmap <buffer> ga: vip:EasyAlign /::/<CR>
xmap <buffer>  a-    :EasyAlign /->/<CR>
xmap <buffer>  a:    :EasyAlign /::/<CR>
