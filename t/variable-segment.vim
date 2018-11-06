filetype plugin on
runtime! plugin/textobj/variable-segment.vim


describe 'iv'
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

    it 'selects between dashes'
        put! = 'foo-bar-baz'
        normal! 6|
        normal civquux
        Expect getline(1) == 'foo-quux-baz'
    end

    it 'selects leading sections with dashes'
        put! = 'bag-of-spam'
        normal! 2|
        normal civjar
        Expect getline(1) == 'jar-of-spam'
    end

    it 'selects ending sections with dashes'
        put! = 'bag-of-spam'
        normal! 9|
        normal civbeans
        Expect getline(1) == 'bag-of-beans'
    end

    it 'selects between small camels'
        put! = 'eggsAndCheese'
        normal! 6|
        normal civOr
        Expect getline(1) == 'eggsOrCheese'
    end

    it 'considers numbers to be capitals on the left boundary'
        put! = '22Skidoo'
        normal! 5|
        normal civProblemsButThisTestAintOne
        Expect getline(1) == '22ProblemsButThisTestAintOne'
    end

    it 'considers numbers to be capitals on the right boundary'
        put! = 'Catch22'
        normal! 2|
        normal civSplit
        Expect getline(1) == 'Split22'
    end

    it 'considers numbers to be a single group'
        put! = 'ABC123DEF'
        normal! 5|
        normal civ456
        Expect getline(1) == 'ABC456DEF'
    end

    it 'recognizes weird capital runs considering the last to be a new group'
        put! = 'MyHTMLParser'
        normal! 4|
        normal civXML
        Expect getline(1) == 'MyXMLParser'
    end

    it 'recognizes weird capital runs on the left'
        put! = 'MyHTMLParser'
        normal! 7|
        normal civNightmare
        Expect getline(1) == 'MyHTMLNightmare'
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

    it 'ignores multiple leading underscores'
        put! = '__doCoolThings'
        normal! 3|
        normal civhowMany
        Expect getline(1) == '__howManyCoolThings'
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

    it 'selects single letter camel sections'
        put! = 'aThingILike'
        normal! 0
        normal civthe
        Expect getline(1) == 'theThingILike'
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

    it 'supports counts'
        put! = 'foo_bar_baz_quux_spam'
        normal! 6|
        normal c3iveggs
        Expect getline(1) == 'foo_eggs_spam'
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

    it 'selects between dashes'
        put! = 'foo-bar-baz'
        normal! 6|
        normal dav
        Expect getline(1) == 'foo-baz'
    end

    it 'selects leading sections with dashes'
        put! = 'bag-of-spam'
        normal! 2|
        normal dav
        Expect getline(1) == 'of-spam'
    end

    it 'selects ending sections with dashes'
        put! = 'bag-of-spam'
        normal! 9|
        normal dav
        Expect getline(1) == 'bag-of'
    end

    it 'selects between small camels'
        put! = 'eggsAndCheese'
        normal! 6|
        normal dav
        Expect getline(1) == 'eggsCheese'
    end

    it 'considers numbers to be capitals on the left boundary'
        put! = '22Skidoo'
        normal! 5|
        normal dav
        Expect getline(1) == '22'
    end

    it 'considers numbers to be capitals on the right boundary'
        put! = 'Catch22'
        normal! 2|
        normal dav
        Expect getline(1) == '22'
    end

    it 'considers numbers to be a single group'
        put! = 'ABC123DEF'
        normal! 5|
        normal dav
        Expect getline(1) == 'ABCDEF'
    end

    it 'recognizes weird capital runs considering the last to be a new group'
        put! = 'MyHTMLParser'
        normal! 4|
        normal dav
        Expect getline(1) == 'MyParser'
    end

    it 'recognizes weird capital runs on the left'
        put! = 'MyHTMLParser'
        normal! 7|
        normal dav
        Expect getline(1) == 'MyHTML'
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

    it 'ignores multiple leading underscores'
        put! = '__doCoolThings'
        normal! 3|
        normal dav
        Expect getline(1) == '__coolThings'
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

    it 'selects single letter camel sections'
        put! = 'aThingILike'
        normal! 0
        normal dav
        Expect getline(1) == 'thingILike'
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

    it 'supports counts'
        put! = 'foo_bar_baz_quux_spam'
        normal! 6|
        normal d3av
        Expect getline(1) == 'foo_spam'
    end

    it 'does not cross right camel boundaries'
        put! = 'fooBar bazQuux'
        normal! 6|
        normal dav
        Expect getline(1) == 'foo bazQuux'
    end
end
