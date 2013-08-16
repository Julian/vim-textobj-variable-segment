filetype plugin on
runtime! plugin/textobj/variable-segment.vim


describe 'snake case' 
    after
        bwipeout!
    end

    it 'selects between underscores'
        put! = 'foo_bar_baz'
        normal! 6|
        normal div
        Expect getline(1) == 'foo_baz'
    end

    it 'selects leading sections'
        put! = 'BAG_OF_SPAM'
        normal! 2|
        normal div
        Expect getline(1) == 'OF_SPAM'
    end

    it 'selects ending sections'
        put! = 'BAG_OF_SPAM'
        normal! 9|
        normal div
        Expect getline(1) == 'BAG_OF'
    end

    it 'ignores leading underscores'
        put! = '_SPAM_EGGS'
        normal! 3|
        normal div
        Expect getline(1) == '_EGGS'
    end

    it 'can match on the left boundary'
        put! = 'hello_world'
        normal! 0
        normal div
        Expect getline(1) == 'world'
    end

    it 'can match on the right boundary'
        put! = 'hello_world'
        normal! $
        normal div
        Expect getline(1) == 'hello'
    end

    it 'does not cross left word boundaries'
        put! = 'foo_bar baz_quux'
        normal! 10|
        normal div
        Expect getline(1) == 'foo_bar quux'
    end

    it 'does not cross right word boundaries'
        put! = 'foo_bar baz_quux'
        normal! 6|
        normal div
        Expect getline(1) == 'foo baz_quux'
    end

    it 'can match on the underscore'
    end
end


describe 'camel case' 
    after
        bwipeout!
    end

    it 'selects between small camels'
        put! = 'eggsAndCheese'
        normal! 6|
        normal div
        Expect getline(1) == 'eggsCheese'
    end

    it 'selects leading small camels and swaps case'
        put! = 'greatQuuxThings'
        normal! 3|
        normal div
        Expect getline(1) == 'quuxThings'
    end

    it 'selects leading small camels and swaps case even with underscores'
        put! = '_greatQuuxThings'
        normal! 3|
        normal div
        Expect getline(1) == '_quuxThings'
    end

    it 'selects leading large camels and preserves case'
        put! = '_ThingDoer'
        normal! 3|
        normal div
        Expect getline(1) == '_Doer'
    end

    it 'selects ending sections'
        put! = 'ohNoWhatsThis'
        normal 12|
        normal div
        Expect getline(1) == 'ohNoWhats'
    end

    it 'ignores leading underscores'
        put! = '_doCoolThings'
        normal! 5|
        normal div
        Expect getline(1) == '_doThings'
    end

    it 'can match on the left boundary'
        put! = 'helloWorld'
        normal! 0
        normal div
        Expect getline(1) == 'world'
    end

    it 'can match on the right boundary'
        put! = 'helloWorld'
        normal! $
        normal div
        Expect getline(1) == 'hello'
    end

    it 'does not cross left word boundaries'
        put! = 'fooBar bazQuux'
        normal! 10|
        normal div
        Expect getline(1) == 'fooBar quux'
    end

    it 'does not cross right word boundaries'
        put! = 'fooBar bazQuux'
        normal! 6|
        normal div
        Expect getline(1) == 'foo bazQuux'
    end
end


describe 'degenerate case'
    after
        bwipeout!
    end

    it 'works'
        put! = 'thing'
        normal div
        Expect getline(1) == ''
    end
end
