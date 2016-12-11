#compdef nyan

_nyan() {
    _arguments \
        {--help,--help}'[show help]' \
        '*: :__nyan_modes'
}

__nyan_modes() {
    _values \
        'mode' \
        'neko[kawaii normal neko]' \
        'usagi[kawaii usa-neko]' \
        'kuma[kawaii kuma-neko]' \
        'github[kawaii octcat]'
}

compdef _nyan nyan
