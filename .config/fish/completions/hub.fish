function __fish_is_arg_n --argument-names n
    test $n -eq (count (string match -v -- '-*' (commandline -poc)))
end

# options
complete -c hub -l help -d 'show help'
complete -c hub -n '__fish_no_arguments' -l version -d 'print the version'

# subcommand
complete -f -c hub -n '__fish_use_subcommand' -a alias -d "[hub] show shell instructions for wrapping git"
complete -f -c hub -n '__fish_use_subcommand' -a browse -d "[hub] browse the project on GitHub"
complete -f -c hub -n '__fish_use_subcommand' -a compare -d "[hub] lookup commit in GitHub Status API"
complete -f -c hub -n '__fish_use_subcommand' -a create -d "[hub] create new repo on GitHub for the current project"
complete -f -c hub -n '__fish_use_subcommand' -a fork -d "[hub] fork origin repo on GitHub"
complete -f -c hub -n '__fish_use_subcommand' -a pull-request -d "[hub] open a pull request on GitHub"
complete -f -c hub -n '__fish_use_subcommand' -a ci-status -d "[hub] display GitHub Status information for a commit"

# alias
complete -x -c hub -n '__fish_seen_subcommand_from alias' -s s -a 'bash zsh sh ksh csh fish' -d 'output shell script suitable for eval'

# browse
complete -f -c hub -n '__fish_seen_subcommand_from browse' -s u -d 'print the URL instead of opening it'
complete -f -c hub -n "__fish_seen_subcommand_from browse; and __fish_is_arg_n 2; and type -q ghq" -a "(ghq list | string match -r '(?<=github\.com/).+')"
complete -f -c hub -n '__fish_seen_subcommand_from browse; and __fish_is_arg_n 3' -a 'wiki commits issues tree' 

# compare
complete -f -c hub -n '__fish_seen_subcommand_from compare' -s u -d 'print the URL instead of opening it'

# create
complete -f -c hub -n '__fish_seen_subcommand_from create' -s p -d 'create a private repository'
complete -x -c hub -n '__fish_seen_subcommand_from create' -s d -d 'repository description'
complete -x -c hub -n '__fish_seen_subcommand_from create' -s h -d 'homepage URL'

# fork
complete -f -c hub -n '__fish_seen_subcommand_from fork' -l no-remote

# pull-request
complete -c hub -n ' __fish_seen_subcommand_from pull-request' -s f -d "skip the check for unpushed commits"
complete -x -c hub -n ' __fish_seen_subcommand_from pull-request' -s m -d "use the first line of <MESSAGE> as pull request title, and the rest as pull request description"
complete -r -c hub -n ' __fish_seen_subcommand_from pull-request' -s F -d "read the pull request title and description from <FILE>"
complete -f -c hub -n ' __fish_seen_subcommand_from pull-request' -s o -d "open the new pull request in a web browser"
complete -f -c hub -n ' __fish_seen_subcommand_from pull-request' -s b -d 'the base branch in "[OWNER:]BRANCH" format'
complete -f -c hub -n ' __fish_seen_subcommand_from pull-request' -s h -d 'the head branch in "[OWNER:]BRANCH" format'

# ci-status
complete -f -c hub -n '__fish_seen_subcommand_from ci-status' -s v -d 'report all checks and their URLs'

# git
complete -c hub -w git
