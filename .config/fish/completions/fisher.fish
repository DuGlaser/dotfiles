complete -c fisher -x -l help -d "Print usage help"
complete -c fisher -x -l version -d "Print fisher version"
complete -c fisher -x -n "__fish_use_subcommand" -a install -d "Install plugins"
complete -c fisher -x -n "__fish_use_subcommand" -a update -d "Update installed plugins"
complete -c fisher -x -n "__fish_use_subcommand" -a remove -d "Remove installed plugins"
complete -c fisher -x -n "__fish_use_subcommand" -a list -d "List installed plugins matching optional regex"
complete -c fisher -x -n "__fish_seen_subcommand_from update remove" -a "(fisher list)"