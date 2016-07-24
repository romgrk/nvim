"================================================================================
" File: job.vim
" Author: romgrk
" Date: 03 Apr 2016
" !::exe [let g:debug = 1 | So]
"================================================================================
if exists('did_jobcontrol') && !exists('g:debug')
    finish
end
let did_jobcontrol = 1

" Job control
command! -nargs=1 Start if (!has_key(job, <q-args>) || get(job[<q-args>], 'id', 0) == 0)
                     \|    call Info('Starting: <q-args>')
                     \|    let job[<q-args>] = <SID>Job.new(_job[<q-args>])
                     \|    call Success(job[<q-args>])
                     \| end
command! -nargs=1 Stop if (has_key(job, <q-args>) && get(job[<q-args>], 'id', 0) != 0)
                     \|    call Warn('Stopping: <q-args>')
                     \|    call pp#print(job[<q-args>].stop())
                     \| end

command! -nargs=* JobStart :call s:com_JobStart(<q-args>)
command! -nargs=1 JobStop  :call s:com_JobStop(<args>)
command! -nargs=* JobList  :call s:com_JobList(<args>)

function! s:com_JobStart (invoke)
    call Info('Starting:', a:invoke)
    return s:Job.new(split(a:invoke, ' '))
endfunc
function! s:com_JobStop (id)
    call Warn('Stoping: <q-args>')
    return s:Job._list[a:id].stop()
endfunc
function! s:com_JobList (...)
    if (a:0 != 0)
        return s:Job._list[get(a:000, 1)]
    end
    let didPrint = v:false
    for ID in keys(s:Job._list)
        let job = s:Job._list[ID]
        if (job.id != 0)
            call Debug('#' . job['id'], job)
            let didPrint = v:true
        end
    endfor
    if (!didPrint)
        call Debug('(no active job)')
    end
endfunc

let s:Job = get(s:, 'Job',
    \ {'id': -1, 'pid': -1, '_list': { } } )

function! s:Job.new (cmd, ...) dict
    let job = copy(self)
    let job.cmd = type(a:cmd) == 1 ? split(a:cmd, ' ') : a:cmd
    let job.id = jobstart(job.cmd, job)
    let job.pid = jobpid(job.id)

    let self._list[job.id] = job

    return job
endfunc
function! s:Job.stop (...) dict
    let id = get(self, 'id', 0)
    if (id != 0)
        let res = jobstop(self.id)
        let self.exit_code = res
        call Warn('Job stopped:', res)
        return res
    end
endfunc
function! s:Job.on_exit (...) dict
    call Warn('jobexit', a:000, self)
    let self.id = 0
endfunc
function! s:Job.on_stdout (...) dict
    let self['out'] = get(self, 'out', []) + a:000
    call Info(self.id, a:000)
endfunc


