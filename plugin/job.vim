" File: job.vim
" Author: romgrk
" Date: 03 Apr 2016
" !::exe [so %]

let Job = {}
function! Job.new (...) dict
    let job = copy(self)
    let job.id = jobstart(a:1, job)
    let job.pid = jobpid(job.id)
    return job
endfunc
function! Job.stop (...) dict
    let id = get(self, 'id', 0)
    if (id != 0)
        let res = jobstop(self.id)
        Warn res
        return res
    end
endfunc
function! Job.on_exit (...) dict
    Warn 'jobexit', self.id, a:000
    let self.id = 0
endfunc
function! Job.on_stdout (...) dict
    call Info(self.id, a:000)
endfunc
