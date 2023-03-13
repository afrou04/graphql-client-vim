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

  "---------- config.jsonからheaderを作成する---------------"
  let l:config_json_list = readfile(expand("~/work/graphql-client-vim/autoload/config.json"))
  let l:config_json = json_decode(join(l:config_json_list))

  echo l:config_json

  let l:headers_dict = l:config_json['Headers']
  let l:headers = []
  for k in keys(l:headers_dict)
    let l:h = "-H '" .  k . ": " . l:headers_dict[k] . "'"
    let l:headers = add(l:headers, l:h)
  endfor
  let l:header = join(l:headers)
  "---------- config.jsonからheaderを作成する---------------"

  let endpoint = "http://localhost:8080/status"
  let curl = "curl -s %s %s"
  let curl = substitute(curl, "%s", l:header, '')
  let curl = substitute(curl, "%s", endpoint, '')

  " TODO: Graphql Requestに変換
  let resp = system(curl)
  let resp = split(resp, '\n')

  call setline("1,$", resp)

endfunction
