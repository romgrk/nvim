
com! CurrentSession call Warn(SessionCurrent())

"augroup session_events
"au!
"au SessionLoadPost * call SessionEnter()
"au QuitPre         * call SessionExit()
"augroup END

fu! SessionCurrent ()
    return xolox#session#find_current_session()
endfu

fu! SessionEnter () "                                                        {{{
    "call vimfiler#_setup()

    call get#Load('.session')
    let g:session.this_session = v:this_session

    " Localrc sourcing...
    "silent execute 'SourceLocalVimrc'
endfu "                                                                      }}}

fu! SessionExit () "                                                         {{{
    if exists('g:session')
        call get#Save('.session')
    end
endfu "                                                                      }}}

