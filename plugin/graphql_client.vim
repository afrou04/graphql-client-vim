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

" Set endpoint url
command! -nargs=0 GQLSetEndpoint call graphql_client#set_endpoint()

" Show graphql docs
command! -nargs=0 GQLShowDocs call graphql_client#show_docs()

