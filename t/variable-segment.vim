filetype plugin on
runtime! plugin/textobj/variable-segment.vim


describe 'iv'
    after
        bwipeout!
    end

    it 'selects between underscores'
        put! = 'foo_bar_baz'
        normal! 6|
        normal civquux
        Expect getline(1) == 'foo_quux_baz'
    end

    it 'selects leading sections'
        put! = 'bag_of_spam'
        normal! 2|
        normal civjar
        Expect getline(1) == 'jar_of_spam'
    end

    it 'selects ending sections'
        put! = 'bag_of_spam'
        normal! 9|
        normal civbeans
        Expect getline(1) == 'bag_of_beans'
    end

    it 'selects between small camels'
        put! = 'eggsAndCheese'
        normal! 6|
        normal civOr
        Expect getline(1) == 'eggsOrCheese'
    end

    it 'ignores leading snake underscores'
        put! = '_spam_eggs'
        normal! 3|
        normal civquux
        Expect getline(1) == '_quux_eggs'
    end

    it 'ignores leading camel underscores'
        put! = '_doCoolThings'
        normal! 3|
        normal civhowMany
        Expect getline(1) == '_howManyCoolThings'
    end

    it 'selects leading small camels and does not swap case'
        put! = 'greatQuuxThings'
        normal! 3|
        normal civdecent
        Expect getline(1) == 'decentQuuxThings'
    end

    it 'selects leading large camels and preserves case'
        put! = 'BigCat'
        normal! 2|
        normal civSmall
        Expect getline(1) == 'SmallCat'
    end

    it 'works on CONSTANT_SECTIONS'
        put! = 'SPAM_AND_EGGS'
        normal! 7|
        normal civOR
        Expect getline(1) == 'SPAM_OR_EGGS'
    end

    it 'works on mixed variables'
        put! = 'getFoo_AndBar'
        normal! 10|
        normal civOr
        Expect getline(1) == 'getFoo_OrBar'
    end

    it 'can match on the underscore'
        put! = 'hello_world'
        normal! 6|
        normal civstrange
        Expect getline(1) == 'strange_world'
    end

    it 'can match on the left snake boundary'
        put! = 'hello_world'
        normal! 0
        normal civgoodbye_cruel
        Expect getline(1) == 'goodbye_cruel_world'
    end

    it 'can match on the right snake boundary'
        put! = 'hello_world'
        normal! $
        normal civhello
        Expect getline(1) == 'hello_hello'
    end

    it 'can match on the left camel boundary'
        put! = 'helloWorld'
        normal! 0
        normal civgoodbyeCruel
        Expect getline(1) == 'goodbyeCruelWorld'
    end

    it 'can match on the right camel boundary'
        put! = 'helloWorld'
        normal! $
        normal civBeautiful
        Expect getline(1) == 'helloBeautiful'
    end

    it 'does not cross left snake boundaries'
        put! = 'foo_bar baz_quux'
        normal! 10|
        normal civspaz
        Expect getline(1) == 'foo_bar spaz_quux'
    end

    it 'does not cross right snake boundaries'
        put! = 'foo_bar baz_quux'
        normal! 6|
        normal civlala
        Expect getline(1) == 'foo_lala baz_quux'
    end

    it 'does not cross left camel boundaries'
        put! = 'fooBar bazQuux'
        normal! 10|
        normal civFez
        Expect getline(1) == 'fooBar FezQuux'
    end

    it 'does not cross right camel boundaries'
        put! = 'fooBar bazQuux'
        normal! 6|
        normal civtHill
        Expect getline(1) == 'footHill bazQuux'
    end

    it 'works in the degenerate case'
        put! = 'thing another'
        normal 2|
        normal civone
        Expect getline(1) == 'one another'
    end
end


describe 'av'
    it 'selects between underscores'
        put! = 'foo_bar_baz'
        normal! 6|
        normal dav
        Expect getline(1) == 'foo_baz'
    end

    it 'selects leading sections'
        put! = 'bag_of_spam'
        normal! 2|
        normal dav
        Expect getline(1) == 'of_spam'
    end

    it 'selects ending sections'
        put! = 'bag_of_spam'
        normal! 9|
        normal dav
        Expect getline(1) == 'bag_of'
    end

    it 'selects between small camels'
        put! = 'eggsAndCheese'
        normal! 6|
        normal dav
        Expect getline(1) == 'eggsCheese'
    end

    it 'ignores leading snake underscores'
        put! = '_spam_eggs'
        normal! 3|
        normal dav
        Expect getline(1) == '_eggs'
    end

    it 'ignores leading camel underscores'
        put! = '_doCoolThings'
        normal! 5|
        normal dav
        Expect getline(1) == '_doThings'
    end

    it 'selects leading small camels and swaps case'
        put! = 'greatQuuxThings'
        normal! 3|
        normal dav
        Expect getline(1) == 'quuxThings'
    end

    it 'selects leading small camels and swaps case even with underscores'
        put! = '_greatQuuxThings'
        normal! 3|
        normal dav
        Expect getline(1) == '_quuxThings'
    end

    it 'selects leading large camels and preserves case'
        put! = 'BigCat'
        normal! 2|
        normal dav
        Expect getline(1) == 'Cat'
    end

    it 'works on CONSTANT_SECTIONS'
        put! = 'SPAM_AND_EGGS'
        normal! 7|
        normal dav
        Expect getline(1) == 'SPAM_EGGS'
    end

    it 'works on mixed variables'
        put! = 'bathRobe_AndBody'
        normal! 5|
        normal dav
        Expect getline(1) == 'bathAndBody'
    end

    it 'can match on the underscore'
        put! = 'hello_world'
        normal! 6|
        normal dav
        Expect getline(1) == 'world'
    end

    it 'can match on the left snake boundary'
        put! = 'hello_world'
        normal! 0
        normal dav
        Expect getline(1) == 'world'
    end

    it 'can match on the right snake boundary'
        put! = 'hello_world'
        normal! $
        normal dav
        Expect getline(1) == 'hello'
    end

    it 'can match on the left camel boundary'
        put! = 'helloWorld'
        normal! 0
        normal dav
        Expect getline(1) == 'world'
    end

    it 'can match on the right camel boundary'
        put! = 'helloWorld'
        normal! $
        normal dav
        Expect getline(1) == 'hello'
    end

    it 'does not cross left snake boundaries'
        put! = 'foo_bar baz_quux'
        normal! 10|
        normal dav
        Expect getline(1) == 'foo_bar quux'
    end

    it 'does not cross right snake boundaries'
        put! = 'foo_bar baz_quux'
        normal! 6|
        normal dav
        Expect getline(1) == 'foo baz_quux'
    end

    it 'does not cross left camel boundaries'
        put! = 'fooBar bazQuux'
        normal! 10|
        normal dav
        Expect getline(1) == 'fooBar quux'
    end

    it 'does not cross right camel boundaries'
        put! = 'fooBar bazQuux'
        normal! 6|
        normal dav
        Expect getline(1) == 'foo bazQuux'
    end
end
