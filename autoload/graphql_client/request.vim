let s:graphql = {}

function! graphql_client#graphql#new() abort
  return s:graphql.new()
endfunction

function! s:graphql.new() abort
  let s:graphql = copy(s:graphql)
  let s:graphql.buffer_name = 'request.graphql'
  return s:graphql
endfunction

function! s:graphql.show() abort
  call self.open_buffer()
  call self.setup_buffer()
endfunction

function! s:graphql.open_buffer() abort
  let buffer_win = bufwinid(self.buffer_name)
  if buffer_win > -1
    call win_gotoid(buffer_win)
  else
    execute ":topleft vnew " . self.buffer_name
  endif
endfunction

function! s:graphql.setup_buffer() abort
  silent 1,$delete _
  set readonly
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction
