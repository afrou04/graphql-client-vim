if exists("g:loaded_graphql_client")
    finish
endif
let g:loaded_graphql_client = 1

let g:graphql_client_endpoint = get(g:, 'graphql_client_endpoint', '')
let g:graphql_client_headers = get(g:, 'graphql_client_headers', {})

" Execute graphql request
command! -nargs=0 GraphqlClientExecute call graphql_client#execute_request()

" TODO: output.jsonに書き込む時にfocusを移さずに書き込むようにする


