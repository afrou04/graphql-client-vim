let s:endpoint = {}

function! graphql_client#endpoint#new() abort
  return s:endpoint.new()
endfunction

function! s:endpoint.new() abort
  let s:endpoint = copy(s:endpoint)
  let s:endpoint.buffer_name = 'graphql_client_endpoint'
  return s:endpoint
endfunction

function! s:endpoint.show() abort
  call self.open_buffer()
  call self.setup_buffer()
endfunction

function! s:endpoint.open_buffer() abort
  let buffer_win = bufwinid(self.buffer_name)
  if buffer_win > -1
    call win_gotoid(buffer_win)
  else
    execute ":horizontal leftabove split " . self.buffer_name
  endif
endfunction

function! s:endpoint.setup_buffer() abort
  silent 1,$delete _
  call setline("1", g:graphql_client_endpoint)
  resize 2
  " setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal hidden
endfunction

" TODO: 
" endpointをバッファで開く
" endpointのファイルタイプをみる
" セーブされたタイミングでエンドポイントを変更する

" WANT: 
" エンドポイントのデフォルトを管理するファイルを用意する
" セーブしたらファイルを更新する
" 環境を立ち上げるときにデフォルトの値をファイルから復元して設定する
