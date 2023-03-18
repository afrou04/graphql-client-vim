let s:request = {}

function! graphql_client#request#new(headers) abort
  let s:request = copy(s:request)
  let s:request.headers = a:headers
  return s:request
endfunction

function! s:request.exec_graphql() abort
  let headers = self.generate_headers()
  let header = join(headers)

  "---------- endpointを作成する---------------"
  let endpoint = g:graphql_client_endpoint
  "---------- endpointを作成する---------------"
  
  "---------- request.graphqlからbodyを作成する---------------"
  let graphql_file = readfile(expand("%:p"))
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
  "---------- curlの組み立て---------------"
  
  echo curl
  
  "---------- graphql requestを実行---------------"
  let resp = system(curl)
  "---------- graphql requestを実行---------------"

  return resp
endfunction

function! s:request.generate_headers() abort 
  let headers = ["-H 'Content-Type: application/json'"]
  for k in keys(self.headers)
    let h = "-H '" .  k . ": " . self.headers[k] . "'"
    let headers = add(headers, h)
  endfor
  return headers
endfunction

