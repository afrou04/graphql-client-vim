let s:workspace = {}

function! graphql_client#workspace#new(workspaces) abort
  return s:workspace.new(a:workspaces)
endfunction

function! s:workspace.new(workspaces) abort
  let s:workspace = copy(s:workspace)
  let s:workspace.buffer_name = 'gqlui'
  let s:workspace.workspaces = a:workspaces
  let s:workspace.current_workspace = ''
  let s:workspace.icons = g:graphql_client_icons
  return s:workspace
endfunction

function! s:workspace.show() abort
  call self.open_buffer()
  call self.setup_buffer()
endfunction

function! s:workspace.open_buffer() abort
  let buffer_win = bufwinid(self.buffer_name)
  if buffer_win > -1
    call win_gotoid(buffer_win)
  else
    execute "topleft vnew " . self.buffer_name
  endif
endfunction

function! s:workspace.setup_buffer() abort
  vertical-resize 40
  setlocal filetype=gqlui
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
  setlocal modifiable

  " clear file
  silent 1,$delete _

  " write workspaces
  call setline(1, '" Press Enter workspace for set endpoint')
  call setline(2, '')

  let i = 3
  for k in keys(self.workspaces)
    let workspace_name = k
    if self.current_workspace == k
      let workspace_name = k.' '.self.icons.current_workspace
    endif
    call setline(i, workspace_name)

    let i += 1
  endfor

  setlocal nomodifiable
endfunction
