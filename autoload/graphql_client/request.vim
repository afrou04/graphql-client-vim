let s:request = {}

function! graphql_client#request#new() abort
  return s:request.new()
endfunction

function! s:request.new() abort
  let s:request = copy(s:request)
  let s:request.buffer_name = 'request.graphql'
  return s:request
endfunction

function! s:request.show() abort
  call self.open_buffer()
  call self.setup_buffer()
endfunction

function! s:request.open_buffer() abort
  let buffer_win = bufwinid(self.buffer_name)
  if buffer_win > -1
    call win_gotoid(buffer_win)
  else
    " 現在のバッファと置き換えるようにバッファを作成
    " execute \":topleft vnew \" . self.buffer_name
    execute "e " . self.buffer_name
  endif
endfunction

function! s:request.setup_buffer() abort
  silent 1,$delete _
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction
