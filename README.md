# vim-textobj-variable-segment

A vim plugin providing a single text object (on `iv`) for
variable segments. A variable segment is defined to be a substring in
an identifier followed by an underscore for snake cased variables or a
substring in an identifier followed by an uppercase character for camel
cased variables.

E.g.:

    foo_ba|r_baz   -> div -> foo_baz
    QU|UX_SPAM     -> div -> SPAM
    eggsAn|dCheese -> div -> eggsCheese
    _privat|e_quux -> div -> _quux

It will also preserve case for small camels when initial segments are deleted:

    _g|etJiggyYo   -> div -> _jiggyYo


`av` right now does the same thing as `iv`, but if you have ideas for how it
should differ feel free to open a ticket (with a most welcome Pull Request if
possible :D ).


Requires [vim-textobj-user](https://github.com/kana/vim-textobj-user).
