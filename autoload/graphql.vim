function! graphql#edit_config() abort
  redraw
  echo 'Open graphql-client-vim config file.'
endfunction

let s:output_file_name = 'output.json'

function! graphql#open_output() abort
  botright vnew output.json

  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction

function! graphql#execute_request() abort
  " output用のfileがなければ表示
  if !bufexists(s:output_file_name) 
    call graphql#open_output()
  endif

  " TODO: Graphql Requestに変換
  let cmd = "curl -s http://localhost:8080/status"
  let resp = system(cmd)
  let resp = split(resp, '\n')
  call setline("1,$", resp)

endfunction
