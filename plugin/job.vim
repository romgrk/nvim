" File: job.vim
" Author: romgrk
" Date: 03 Apr 2016
" !::exe [so %]

" Job control
command! -nargs=1 Start if (!has_key(job, <q-args>) || get(job[<q-args>], 'id', 0) == 0)
                     \|    call Info('Starting: <q-args>')
                     \|    let job[<q-args>] = Job.new(_job[<q-args>])
                     \|    call Success(job[<q-args>])
                     \| end
command! -nargs=1  Stop if (has_key(job, <q-args>) && get(job[<q-args>], 'id', 0) != 0)
                     \|    call Warn('Stopping: <q-args>')
                     \|    call pp#print(job[<q-args>].stop())
                     \| end

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
