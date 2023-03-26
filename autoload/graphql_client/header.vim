let s:header = {}

function! graphql_client#header#new() abort
  return s:header.new()
endfunction

function! s:header.new() abort
  let s:header = copy(s:header)
  let s:header.buffer_name = 'graphql_client_header'
  return s:header
endfunction

function! s:header.show() abort
  call self.open_buffer()
  call self.setup_buffer()
endfunction

function! s:header.open_buffer() abort
  let buffer_win = bufwinid(self.buffer_name)
  if buffer_win > -1
    call win_gotoid(buffer_win)
  else
    execute ":horizontal leftabove split " . self.buffer_name
  endif
endfunction

function! s:header.setup_buffer() abort
  silent 1,$delete _
  call setline("1", "GraphQL Endpoint: " . g:graphql_client_endpoint)
  resize 2
  set readonly
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction
