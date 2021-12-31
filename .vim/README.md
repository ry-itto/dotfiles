# Vim Setting

## Key bindings

### Common settings

| Title  | Key |
| ------ | --- |
| leader | \   |

### File navigation

| Key | Action          | Description       |
| --- | --------------- | ----------------- |
| C-t | :NERDTreeToggle | Toggle NERDTree   |
| C-n | :NERDTreeFocus  | Focus to NERDTree |

### Editor actions

| Key            | Action                            | Description                       |
| -------------- | --------------------------------- | --------------------------------- |
| gd             | \<Plug\>(coc-definition)          | Go to definition                  |
| gy             | \<Plug\>(coc-type-definition)     | Go to type definition             |
| gi             | \<Plug\>(coc-implementation)      | Go to implementation              |
| gr             | \<Plug\>(coc-references)          | Go to refrerences                 |
| gb             | \<C-o\>                           | Go back                           |
| \<leader\> aap | \<Plug\>(coc-codeaction-selected) | Code action for current paragraph |
| \<leader\> aw  | \<Plug\>(coc-codeaction-selected) | Code action for current word      |

### Flutter

| Key          | Action              | Description           |
| ------------ | ------------------- | --------------------- |
| \<leader\>fa | :FlutterRun         | Flutter run           |
| \<leader\>fq | :FlutterQuit        | Flutter quit          |
| \<leader\>fr | :FlutterHotReload   | Flutter HotReload     |
| \<leader\>fR | :FlutterHotRestart  | Flutter HotRestart    |
| \<leader\>fD | :FlutterVisualDebug | Flutter Virtual Debug |
