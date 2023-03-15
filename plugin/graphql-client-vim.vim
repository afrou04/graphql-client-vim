if exists("g:loaded_graphql_client_vim")
    finish
endif
let g:loaded_graphql_client_vim = 1

let g:graphql_client_vim_endpoint = get(g:, 'graphql_client_vim_endpoint', '')
let g:graphql_client_vim_headers = get(g:, 'graphql_client_vim_headers', {})

" Edit http header.json file
" command! -nargs=0 GraphqlClientEditConfig call graphql#edit_config()

" Open output.json buffer
command! -nargs=0 GraphqlClientOpenOutput call graphql#open_output()

" Execute graphql request
command! -nargs=0 GraphqlClientExecute call graphql#execute_request()

" 現在のwindowをGraphql Editorに乗り換える


