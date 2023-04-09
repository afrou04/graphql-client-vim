syntax clear

exe 'syn match gqlui_current_workspace /'.g:graphql_client_icons.current_workspace.'/'
syn match graphql_client_comment /^".*$/
hi default link graphql_client_comment Comment
if &background ==? 'light'
  hi gqlui_current_workspace guifg=#00AA00
else
  hi gqlui_current_workspace guifg=#88FF88
endif

