let s:graphql_client = {}
let s:graphql_client_instance = {}

function! s:init() abort
  if empty(s:graphql_client_instance)
    let s:graphql_client_instance = s:graphql_client.new()
  endif

  return s:graphql_client_instance
endfunction

function! s:graphql_client.new() abort
  let s:graphql_client.curl = graphql_client#curl#new(g:graphql_client_headers)
  let s:graphql_client.request = graphql_client#request#new()
  let s:graphql_client.output = graphql_client#output#new()
  let s:graphql_client.header = graphql_client#header#new()
  return s:graphql_client
endfunction

function! s:graphql_client.can_exec() abort
  let extension = expand('%:e')
  if extension != 'graphql'
    echoerr "Received *." .extension.". Please should execute *.graphql!"
    return 0
  endif
  return 1
endfunction

function! graphql_client#execute_request() abort
  call s:init()

  if !s:graphql_client.can_exec()
    return
  endif

  " 現在のファイルのfocusを記憶しておく
  let graphql_win_id = win_getid()

  let resp = s:graphql_client.curl.exec_graphql()
  call s:graphql_client.output.show()
  call s:graphql_client.output.write(split(resp, '\n'))

  call win_gotoid(graphql_win_id)
endfunction

function! graphql_client#open_ui() abort
  call s:init()

  call s:graphql_client.header.show()
  call s:graphql_client.request.show()
  call s:graphql_client.output.show()
endfunction

