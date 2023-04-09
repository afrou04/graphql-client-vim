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

  nnoremap <silent><buffer> <CR> :call <sid>method('set_current_workspace')<CR>

  call self.redraw()
  setlocal nomodifiable
endfunction

function! s:workspace.redraw() abort
  setlocal modifiable
  " clear file
  silent 1,$delete _

  " write workspaces
  call setline(1, '" Press Enter for set endpoint')
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

" TODO: 現在のworkspaceで設定されている情報を表示する
function! s:workspace.show_current_workspace() abort
endfunction

" TODO: requestするときにここの現在のworkspace情報を元にendpoint, headerを設定されるようにする
function! s:workspace.set_current_workspace() abort
  let content = getline('.')
  for k in keys(self.workspaces)
    if content == k
      let self.current_workspace = k
      call self.redraw()
      echo 'set '.self.current_workspace.' workspace'
      return
    endif
  endfor
endfunction

function! s:method(method_name) abort
  return s:workspace[a:method_name]()
endfunction
