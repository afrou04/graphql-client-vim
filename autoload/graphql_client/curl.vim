let s:curl = {}

function! graphql_client#curl#new(headers) abort
  let s:curl = copy(s:curl)
  let s:curl.headers = a:headers
  return s:curl
endfunction

function! s:curl.set_headers(headers) abort
  let self.headers = a:headers
endfunction

function! s:curl.exec_graphql() abort
  let headers = self.generate_headers()
  let endpoint = self.generate_endpoint()
  let body = self.generate_body()
  let curl = self.build_curl(endpoint, headers, body)
  return system(curl)
endfunction

function! s:curl.generate_headers() abort 
  let headers = ["-H 'Content-Type: application/json'"]
  for k in keys(self.headers)
    let h = "-H '" .  k . ": " . self.headers[k] . "'"
    let headers = add(headers, h)
  endfor
  return headers
endfunction

function! s:curl.generate_endpoint() abort 
  return g:graphql_client_endpoint
endfunction

function! s:curl.generate_body() abort 
  let graphql_file = readfile(expand("%:p"))
  " bufnr("%")
  let query = join(graphql_file, "")
  "NOTE: 引数の文字列に対してエスケープしておかないとparaserがエラーになる"
  let query = substitute(query, "\"", '\\\"', 'g')
  return json_encode({"query": query})
endfunction

function! s:curl.build_curl(endpoint, headers, body) abort 
  let header = join(a:headers)

  let curl = "curl -s -X POST %E %H -d '%B'"
  let curl = substitute(curl, "%E", a:endpoint, '')
  let curl = substitute(curl, "%H", header, '')
  return substitute(curl, "%B", a:body, '')
endfunction
