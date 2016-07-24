if filereadable('Cargo.toml')
    set makeprg=cargo
else
    set makeprg=rustc
end
