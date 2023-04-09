if exists("g:loaded_graphql_client")
    finish
endif
let g:loaded_graphql_client = 1

let g:graphql_client_endpoint = get(g:, 'graphql_client_endpoint', '')
let g:graphql_client_workspaces = get(g:, 'graphql_client_workspaces', {})
let g:graphql_client_headers = get(g:, 'graphql_client_headers', {})
let g:graphql_client_headers = get(g:, 'graphql_client_headers', {})
let g:graphql_client_icons = get(g:, 'graphql_client_icons', {
      \  'current_workspace': '✓'
      \})

augroup GraphqlClient
  autocmd!
  autocmd FileType gqlui autocmd BufEnter,WinEnter <buffer> stopinsert
augroup END

" Execute graphql request
command! -nargs=0 GQLExecute call graphql_client#execute_request()
" Set endpoint url
command! -nargs=0 GQLSetEndpoint call graphql_client#set_endpoint()
" Show graphql workspace
command! -nargs=0 GQLShowWorkSpace call graphql_client#show_workspace()

