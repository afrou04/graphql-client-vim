let s:output_file_name = 'output.json'

function! graphql#open_output() abort
  botright vnew output.json

  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction

function! graphql#execute_request() abort
  let extension = expand('%:e')
  if extension != 'graphql'
    echoerr "Received *." .extension.". Please should execute *.graphql!"
    return
  endif

  "---------- headerを作成する---------------"
  " TODO: headersの存在チェックをしてハンドリングする必要がある
  let headers = ["-H 'Content-Type: application/json'"]
  for k in keys(g:graphql_client_vim_headers)
    let h = "-H '" .  k . ": " . g:graphql_client_vim_headers[k] . "'"
    let headers = add(headers, h)
  endfor
  echo g:graphql_client_vim_headers
  echo headers
  let header = join(headers)
  "---------- headerを作成する---------------"

  "---------- endpointを作成する---------------"
  let endpoint = g:graphql_client_vim_endpoint
  "---------- endpointを作成する---------------"
  "
  "---------- request.graphqlからbodyを作成する---------------"
  let graphql_file = readfile(expand("~/work/graphql-client-vim/autoload/request.graphql"))
  " bufnr("%")
  let query = join(graphql_file, "")
  "NOTE: 引数の文字列に対してエスケープしておかないとparaserがエラーになる"
  let query = substitute(query, "\"", '\\\"', 'g')
  let body = json_encode({"query": query})
  "---------- endpointを作成する---------------"

  "---------- curlの組み立て---------------"
  let curl = "curl -s -X POST %E %H -d '%B'"
  let curl = substitute(curl, "%E", endpoint, '')
  let curl = substitute(curl, "%H", header, '')
  let curl = substitute(curl, "%B", body, '')
  echo curl
  "---------- curlの組み立て---------------"

  "---------- graphql requestを実行---------------"
  let resp = system(curl)
  let resp = split(resp, '\n')
  "---------- graphql requestを実行---------------"

  "---------- output.jsonにresponseの結果を書き込み---------------"
  " output用のfileがなければ表示
  if !bufexists(s:output_file_name) 
    call graphql#open_output()
  endif

  " FIXME: response量が多いあとに、少ないresponseで書き換えると一部残ってしまうバグがある
  call setline("1,$", resp)
  "---------- output.jsonにresponseの結果を書き込み---------------"

  "---------- TODO: jqコマンドがあればformat ---------------"
  :%!jq '.'
  " call system("cat output.json | jq .")
  "---------- jqコマンドがあればformat ---------------"
endfunction
