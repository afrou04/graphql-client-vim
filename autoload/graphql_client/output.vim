let s:output = {}

function! graphql_client#output#new() abort
  return s:output.new()
endfunction

function! s:output.new() abort
  let s:output = copy(s:output)
  let s:output.buffer_name = 'output.json'
  let s:output.exist_jq = system('jq -h &> /dev/null && echo 0 || echo 1') == 0
  return s:output
endfunction

function! s:output.show() abort
  if bufexists(self.buffer_name) 
    " focusを移すようにしないといけない
    return
  endif
  call self.setup_buffer()
endfunction

function! s:output.write(strings) abort
  silent 1,$delete _
  call setline("1", a:strings)

  "---------- jqコマンドがあればformat ---------------"
  if self.exist_jq
    :%!jq '.'
  endif
  "---------- jqコマンドがあればformat ---------------"
endfunction

function! s:output.setup_buffer() abort
  botright vnew output.json

  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction
