# vim-textobj-variable-segment

A vim plugin providing a single text object (on `iv` and `av`) for
variable segments. A variable segment is defined to be a substring in
any identifier character followed by an underscore ("snake case") or
a lowercase identifier character followed by an uppercase character
("camel case").

E.g.:

    foo_ba|r_baz    -> civquux -> foo_quux_baz
    QU|UX_SPAM      -> civLOTS_OF -> LOTS_OF_SPAM
    eggsAn|dCheese  -> civOr -> eggsOrCheese
    _privat|e_thing -> civone -> _one_thing

    foo_ba|r_baz    -> dav -> foo_baz
    QU|UX_SPAM      -> dav -> SPAM
    eggsAn|dCheese  -> dav -> eggsCheese
    _privat|e_thing -> dav -> _thing


It will also preserve case for small camels when initial segments are deleted
(with `av`):

    _g|etJiggyYo   -> dav -> _jiggyYo


Requires [vim-textobj-user](https://github.com/kana/vim-textobj-user).
