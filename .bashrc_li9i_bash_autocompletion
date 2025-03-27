# ==============================================================================
# COMPLETION FUNCTIONS
# ==============================================================================
_git_multistatus_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local opts="--branch --show --help"

    case "$prev" in
        --branch)
            COMPREPLY=($(compgen -W "$(git branch --format='%(refname:short)' 2>/dev/null)" -- "$cur"))
            return 0
            ;;
    esac

    # Show options when cursor is at start or after space
    if [[ $cur == -* || $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    fi
}
# ------------------------------------------------------------------------------
_git_multirebase_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local opts="--branch --help"

    case "$prev" in
        --branch)
            COMPREPLY=($(compgen -W "$(git branch --format='%(refname:short)' 2>/dev/null)" -- "$cur"))
            return 0
            ;;
    esac

    if [[ $cur == -* || $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    fi
}
# ------------------------------------------------------------------------------
_httphere_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local opts="--port --directory --help"

    case "$prev" in
        --port)
            return 0  # Let user type port number
            ;;
        --directory)
            _filedir -d
            return 0
            ;;
    esac

    if [[ $cur == -* || $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    fi
}
# ------------------------------------------------------------------------------
_grep_and_replace_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local opts="--dry-run --help"

    if [[ $cur == -* || $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    fi
}
# ------------------------------------------------------------------------------
_find_and_rename_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local opts="--dry-run --help"

    if [[ $cur == -* || $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    fi
}
# ------------------------------------------------------------------------------
_recently_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local prev=${COMP_WORDS[COMP_CWORD-1]}
    local opts="--exclude --help"

    case "$prev" in
        --exclude)
            _filedir -d
            return 0
            ;;
    esac

    if [[ $cur == -* ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    elif [[ $COMP_CWORD -eq 1 || $COMP_CWORD -eq 2 ]]; then
        _filedir -d
    fi
}
# ==============================================================================
# COMPLETION REGISTRATION
# ==============================================================================
complete -F _git_multistatus_completion git-multistatus
complete -F _git_multirebase_completion git-multirebase
complete -F _git_is_local_synced_completion git-is-local-synced-with-remote
complete -F _httphere_completion httphere0 httphere1
complete -F _grep_and_replace_completion grep_and_replace
complete -F _find_and_rename_completion find_and_rename
complete -F _recently_completion recently
complete -F _docker_image_completion get_local_digest get_remote_digest
