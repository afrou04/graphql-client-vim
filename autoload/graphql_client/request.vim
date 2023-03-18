let s:request = {}

function! graphql_client#request#new(headers) abort
  let s:request = copy(s:request)
  let s:request.headers = a:headers
  return s:request
endfunction

function! s:request.exec_graphql() abort
  let headers = self.generate_headers()
  let endpoint = self.generate_endpoint()
  let body = self.generate_body()
  let curl = self.build_request(endpoint, headers, body)
  return system(curl)
endfunction

function! s:request.generate_headers() abort 
  let headers = ["-H 'Content-Type: application/json'"]
  for k in keys(self.headers)
    let h = "-H '" .  k . ": " . self.headers[k] . "'"
    let headers = add(headers, h)
  endfor
  return headers
endfunction

function! s:request.generate_endpoint() abort 
  return g:graphql_client_endpoint
endfunction

function! s:request.generate_body() abort 
  let graphql_file = readfile(expand("%:p"))
  " bufnr("%")
  let query = join(graphql_file, "")
  "NOTE: 引数の文字列に対してエスケープしておかないとparaserがエラーになる"
  let query = substitute(query, "\"", '\\\"', 'g')
  return json_encode({"query": query})
endfunction

function! s:request.build_request(endpoint, headers, body) abort 
  let header = join(a:headers)

  let curl = "curl -s -X POST %E %H -d '%B'"
  let curl = substitute(curl, "%E", a:endpoint, '')
  let curl = substitute(curl, "%H", header, '')
  return substitute(curl, "%B", a:body, '')
endfunction
