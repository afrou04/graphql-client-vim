let s:workspace = {}

function! graphql_client#workspace#new(workspaces) abort
  return s:workspace.new(a:workspaces)
endfunction

function! s:workspace.new(workspaces) abort
  let s:workspace = copy(s:workspace)
  let s:workspace.buffer_name = 'gql_workspace'
  let s:workspace.workspaces = a:workspaces
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
  silent 1,$delete _
  echo self.workspaces
  " TODO: globalのconfigからkeyで設定
  " call setline("1", g:graphql_client_workspace)
  vertical-resize 40
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction
