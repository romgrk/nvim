setlocal nonumber

nmap <buffer> c. acc


hi! link fugitiveHash TextWarning

hi! link fugitiveSymbolicRef Normal

hi! link fugitiveHeader Comment
hi! link fugitiveHeading Comment

hi! link fugitiveCount            Normal
hi! link fugitiveUntrackedHeading Normal
hi! link fugitiveUnstagedHeading  Normal
hi! link fugitiveStagedHeading    Normal

hi! link fugitiveUntrackedSection TextError
hi! link fugitiveUnstagedSection  TextError
hi! link fugitiveStagedSection    TextSuccess

hi! link fugitiveUntrackedModifier TextError
hi! link fugitiveUnstagedModifier  TextError
hi! link fugitiveStagedModifier    TextSuccess
