if exists("g:loaded_graphql_client")
    finish
endif
let g:loaded_graphql_client = 1

let g:graphql_client_endpoint = get(g:, 'graphql_client_endpoint', '')
let g:graphql_client_headers = get(g:, 'graphql_client_headers', {})

" Execute graphql request
command! -nargs=0 GQLExecute call graphql_client#execute_request()

" Open graphql client
" command! -nargs=0 GQLUI call graphql_client#open_ui()

" Open endpoint ui
command! -nargs=0 GQLOpenEndpoint call graphql_client#open_endpoint()

