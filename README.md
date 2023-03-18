# graphql-client-vim

This vim plugin provides graphql client features. Execute requests from a GraphQL file and immediately display the response.

## Usage

- :GraphQLClientExecute current buffer (*.graphql) as graphql query.

## Installation

dein
```dein.toml
[[plugins]]
repo = 'TakuroSugahara/graphql-client-vim'
https://github.com/
```

Neobundle
```
NeoBundle 'TakuroSugahara/graphql-client-vim'
```

Plug 
```
Plug 'jparise/vim-graphql'
```

### setting config
```vimL
let g:graphql_client_headers = {
\ 'authorization': 'Bearer your token here'
\ }
let g:graphql_client_endpoint = 'http://localhost:8080/api/graphql'
```

### Requirements

- [curl](https://github.com/curl/curl)

### Want requirements

- [jq](https://github.com/stedolan/jq)
  - Format a GraphQL response in JSON format.

### TODO

- GraphQL schema parsing feature
  - Provides auto-completion and error detection capabilities.
