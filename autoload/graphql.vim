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
  "---------- config.jsonをjsonとして変数に吐き出す---------------"
  " TODO: fileが存在してなかったら削除したりとかする必要がある
  let l:config_json_list = readfile(expand("~/work/graphql-client-vim/autoload/config.json"))
  let l:config_json = json_decode(join(l:config_json_list))
  "---------- config.jsonをjsonとして変数に吐き出す---------------"

  "---------- config.jsonからheaderを作成する---------------"
  let l:headers_dict = l:config_json['headers']
  " TODO: headersの存在チェックをしてハンドリングする必要がある
  let l:headers = ["-H 'Content-Type: application/json'"]
  for k in keys(l:headers_dict)
    let l:h = "-H '" .  k . ": " . l:headers_dict[k] . "'"
    let l:headers = add(l:headers, l:h)
  endfor
  let l:header = join(l:headers)
  "---------- config.jsonからheaderを作成する---------------"

  "---------- config.jsonからendpointを作成する---------------"
  let l:endpoint = l:config_json['endpoint']
  "---------- config.jsonからendpointを作成する---------------"
  "
  "---------- request.graphqlからbodyを作成する---------------"
  let l:graphql_file = readfile(expand("~/work/graphql-client-vim/autoload/request.graphql"))
  let l:query = join(l:graphql_file, "")
  "NOTE: 引数の文字列に対してエスケープしておかないとparaserがエラーになる"
  let l:query = substitute(l:query, "\"", '\\\"', 'g')
  echo l:query
  let l:body = json_encode({"query": query})
  "---------- config.jsonからendpointを作成する---------------"

  "---------- curlの組み立て---------------"
  let curl = "curl -s -X POST %E %H -d '%B'"
  let curl = substitute(curl, "%E", l:endpoint, '')
  let curl = substitute(curl, "%H", l:header, '')
  let curl = substitute(curl, "%B", l:body, '')
  echo curl
  "---------- curlの組み立て---------------"

  "---------- curlで graphql requestを実行---------------"
  let resp = system(curl)
  let resp = split(resp, '\n')
  echo resp
  "---------- curlで graphql requestを実行---------------"

  "---------- output.jsonにresponseの結果を書き込み---------------"
  " output用のfileがなければ表示
  if !bufexists(s:output_file_name) 
    call graphql#open_output()
  endif

  call setline("1,$", resp)
  "---------- output.jsonにresponseの結果を書き込み---------------"

  "---------- TODO: jqコマンドがあればformat ---------------"
  :%!jq '.'
  " call system("cat output.json | jq .")
  "---------- jqコマンドがあればformat ---------------"
endfunction
