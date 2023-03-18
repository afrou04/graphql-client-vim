let s:graphql_client = {}
let s:graphql_client_instance = {}

function! s:init() abort
  if empty(s:graphql_client_instance)
    let s:graphql_client_instance = s:graphql_client.new()
  endif

  return s:graphql_client_instance
endfunction

function! s:graphql_client.new() abort
  let s:graphql_client.request = graphql_client#request#new(g:graphql_client_headers)
  let s:graphql_client.output = graphql_client#output#new()
  return s:graphql_client
endfunction

function! graphql_client#execute_request() abort
  call s:init()

  let extension = expand('%:e')
  if extension != 'graphql'
    echoerr "Received *." .extension.". Please should execute *.graphql!"
    return
  endif

  let resp = s:graphql_client.request.exec_graphql()

  call s:graphql_client.output.show()
  call s:graphql_client.output.write(split(resp, '\n'))
endfunction

