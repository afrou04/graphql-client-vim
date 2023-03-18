let s:output = {}

function! graphql_client#output#new() abort
  return s:output.new()
endfunction

function! s:output.new() abort
  let s:output = copy(s:output)
  let s:output.buffer_name = 'output.json'
  return s:output
endfunction

function! s:output.show() abort
  if bufexists(self.buffer_name) 
    return
  endif
  call self.setup_buffer()
endfunction

function! s:output.write(strings) abort
  silent 1,$delete _
  call setline("1", a:strings)

  "---------- TODO: jqコマンドがあればformat ---------------"
  :%!jq '.'
  " call system("cat output.json | jq .")
  "---------- jqコマンドがあればformat ---------------"
endfunction

function! s:output.setup_buffer() abort
  botright vnew output.json

  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction
