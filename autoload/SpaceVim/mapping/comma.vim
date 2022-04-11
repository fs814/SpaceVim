function! SpaceVim#mapping#comma#init() abort
  call SpaceVim#logger#debug('init , key bindings')
  nnoremap <silent><nowait> [,] :<c-u>LeaderGuide ","<CR>
  nmap , [,]
  let g:_spacevim_mappings_comma = {}
  let g:_spacevim_mappings_prefixs['[,]'] = {'name' : '+, prefix'}
  let g:_spacevim_mappings_comma.h = {'name' : '+Switch File'}
endfunction

function! SpaceVim#mapping#comma#def(m, keys, cmd, desc, is_cmd, ...) abort
  let is_visual = a:0 > 0 ? a:1 : 0
  if a:is_cmd
     let cmd = ':<C-u>' . a:cmd . '<CR>'
     let xcmd = ':' . a:cmd . '<CR>'
     let lcmd = a:cmd
  else
    let cmd = a:cmd
    let xcmd = a:cmd
    let feedkey_m = a:m =~# 'nore' ? 'n' : 'm'
    if a:cmd =~? '^<plug>'
       let lcmd = 'call feedkeys("\' . a:cmd . '", "' . feedkey_m . '")'
    else
       let lcmd = 'call feedkeys("' . a:cmd . '", "' . feedkey_m . '")'
    endif
  endif
  exe a:m . ' <silent> [,]' . join(a:keys, '') . ' ' . substitute(cmd, '|', '\\|', 'g')
  if is_visual
    if a:m ==# 'nnoremap'
      exe 'xnoremap <silent> [,]' . join(a:keys, '') . ' ' . substitute(xcmd, '|', '\\|', 'g')
    elseif a:m ==# 'nmap'
      exe 'xmap <silent> [,]' . join(a:keys, '') . ' ' . substitute(xcmd, '|', '\\|', 'g')
    endif
  endif
  if len(a:keys) == 2
    if type(a:desc) == 1
      let g:_spacevim_mappings_comma[a:keys[0]][a:keys[1]] = [lcmd, a:desc]
    else
      let g:_spacevim_mappings_comma[a:keys[0]][a:keys[1]] = [lcmd, a:desc[0], a:desc[1]]
    endif
  elseif len(a:keys) == 3
    if type(a:desc) == 1
      let g:_spacevim_mappings_comma[a:keys[0]][a:keys[1]][a:keys[2]] = [lcmd, a:desc]
    else
      let g:_spacevim_mappings_comma[a:keys[0]][a:keys[1]][a:keys[2]] = [lcmd, a:desc[0], a:desc[1]]
    endif
  elseif len(a:keys) == 1
    if type(a:desc) == 1
      let g:_spacevim_mappings_comma[a:keys[0]] = [lcmd, a:desc]
    else
      let g:_spacevim_mappings_comma[a:keys[0]] = [lcmd, a:desc[0], a:desc[1]]
    endif
  endif
  "if type(a:desc) == 1
  ""  call SpaceVim#mapping#menu(a:desc, '[,]' . join(a:keys, ''), lcmd)
  "else
  ""  call SpaceVim#mapping#menu(a:desc[0], '[,]' . join(a:keys, ''), lcmd)
  "endif
  call extend(g:_spacevim_mappings_prefixs['[,]'], get(g:, '_spacevim_mappings_comma', {}))
endfunction
