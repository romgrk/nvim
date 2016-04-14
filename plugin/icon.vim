" !::exe [so %]
"Directories:
" dir                     
" dir.alt             
" dir.link          
" link              
" dir.npm           
" dir.git               
" dir.config          

"Files:
" file              
" file.link         
" binary            
" archive           
" *.zip,*.gz        
" *.txt             

"Scripts:
" *.js                
" *.ts                
" *.coffee            
" *.json,*.cson       
" *.py              
" polymer*.js                       
" *.rb                           

"Shell:
" *.sh,*.zsh        

"Markup:
" *.html               
" *.md,markdown       
" *.xml               
" *.css                
" *.less              
" *.scss,*.sass        

"Compiled:
" *.c               
" *.cc,*.cpp        
" *.hs,*.lhs        

"Build:
" *akefile          
" package.json        
" .*ignore          

"Documents:
" *.jpg,*.jpeg       
" *.png              
" *.mp4              
" *.gif             
" *.pdf             
" *.doc,*.docx      

"##

" arrow-up      
" arrow-down    

" heart    
" thunder  
" at       
" lock     
" clean    
" warn     
" help     
" info     
" harn     
" radio-0  
" radio-1  
" shield   
" github   
" github2  
" plus     ✚
" asterisk ✱
" }        ❴
" {        ❵
" star     
" v-8      █
" v-7      ▉
" v-6      ▊
" v-5      ▋
" v-4      ▌
" v-3      ▍
" v-2      ▎
" v-1      ▏
" v-half   ▐
" a-25     ░
" a-50     ▒
" a-75     ▓
" b-top    ▔
" v-line   ▕
" h-1      ▁
" h-2      ▂
" h-3      ▃
" h-4      ▄
" h-5      ▅
" h-6      ▆
" h-7      ▇
" h-8      █
" t-4      ◥
" t-3      ◤
" t-2      ◣
" t-1      ◢
" circle   ●
" e-circle ◯
" 3em      ⸻

"###

"end-of-icons
"           
"                
"                     
"                     
"                   
"                   
"             

"                 
"                         
 "              
 "      

let icons = {}
let ext   = {}
"let icons.ext = ext

let target = "ext"

for line in readfile(expand('<sfile>'))
    if line =~# "###" | break | end
    if line =~# "##"  | let target = "icons" | end
    let matches = matchlist(line, '\v"\s*([^ ]+)\s+(.)')
    if len(matches) < 2
        continue
    end
    let [rule, icon] = matches[1:2]
    if len(rule) == 0 || len(icon) == 0
        continue
    end
    for type in split(rule, ',')
        let {target}[type] = icon
    endfor
endfor

function! Icon (...)
    if exists('g:icons[a:1]')
        return g:icons[a:1]
    else
        return call('FtIcon', a:000)
    end
endfu

function! FtIcon (...)
    let name = (a:0 ? a:1 : bufname('%'))

    for k in keys(g:ext)
        if name =~ glob2regpat(k)
            return ' ' . g:ext[k] . ' '
        end
    endfor

    if exists('*WebDevIconsGetFileTypeSymbol')
        let icon = WebDevIconsGetFileTypeSymbol(name)
        if (icon ==# ' ')
            let icon = ''
        end
    endif

    return ' ' . icon . ' '
endfunc

finish

      
        
      

                

                    
             
                   
                      
                           
       

               
         
               
           
     
           
           
       
     
             
       
                   
                   
             
         
               
       
             
             


 ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉ ┊ ┋ ┌ ┍ ┎ ┏ ┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ┚ ┛ ├ ┝ ┞ ┟ ┠ ┡ ┢ ┣ ┤ ┥ ┦
 ┧ ┨ ┩ ┪ ┫ ┬ ┭ ┮ ┯ ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┺ ┻ ┼ ┽ ┾ ┿ ╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ╊ ╋ ╌
 ╍ ╎ ╏ ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ ╚ ╛ ╜ ╝ ╞ ╟ ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ╪ ╫ ╬ ╭ ╮ ╯ ╰ ╱ ╲ ╳
 ╴ ╵ ╶ ╷ ╸ ╹ ╺ ╻ ╼ ╽ ╾


" Font?
            
                  
                  
    
            
                    
                        
      
              
              
                                
                  
                    
                
             
                          
                

                                  
                

                            
          
                   
                  
                    
                      
                            
            
                         
  
                      
                      
                                
                                                   
      
          
      
          

         
        
    
              
         
              
              

          
            
          
                      
                         
                        
                
            
                
       
                        
                    
                        
                        
                  
            
                                 
                          
                        
                  
                  

                              
    
         
                          
        
          
              
              
    
    
                            
                    
                        
            
                        
