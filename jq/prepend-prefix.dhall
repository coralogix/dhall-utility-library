let Prelude = (../imports.dhall).Prelude

let prependPrefix
    {- prependPrefix is a helper function that helps drastically simplify wrapping
    -- shell scripts that draw upon the contents of a dhall-to-json call by allowing
    -- Dhall to return the precise objects (and in which specific order) that should
    -- be extracted by the wrapping shell script.
    --
    -- For example, consider the following record (record.dhall):
    --   { foo =
    --     { one = "a"
    --     , two = "b"
    --     }
    --   , bar =
    --     { three = "c"
    --     , four = "d"
    --     }
    --   }
    --
    -- How best to get a shell script to print out the following?
    --    a
    --    b
    --    c
    --    d
    --
    -- This would map to the following bash calls:
    --    object=$(dhall-to-json --file ./record.dhall | jq -c)
    --    jq -r '.foo.one'
    --    jq -r '.foo.two'
    --    jq -r '.bar.three'
    --    jq -r '.bar.four'
    --
    -- The easiest and most maintainable way to get this list of jq
    -- filters (particularly when foo is actually ./foo/package.dhall)
    -- is thus:
    --
    --  let foo =
    --    { one = "a"
    --    , two = "b"
    --    , objects = [ "one" , "two" ]
    --    }
    --
    --  let bar =
    --    { three = "c"
    --    , four = "d"
    --    , objects = [ "three" , "four" ]
    --    }
    --
    --  in { foo
    --     , bar
    --     , objects =
    --           prependPrefix "foo" foo.objects
    --         # prependPrefix "bar" bar.objects
    --     }
    --
    -- and then simply calling `.objects` to get the list of jq filters.
    -- Note that this also allows you to temporarily drop objects from
    -- jq from within the Dhall record, without altering the type of the
    -- Dhall record.
    -}
    : ∀(prefix : Text) → ∀(objects : List Text) → List Text
    = λ(prefix : Text) →
      λ(objects : List Text) →
        Prelude.List.map
          Text
          Text
          (λ(object : Text) → "${prefix}.${object}")
          objects

let tests =
      { non-empty-list =
            assert
          : prependPrefix "pre" [ "foo", "bar" ] ≡ [ "pre.foo", "pre.bar" ]
      , empty-list =
          λ(a : Text) →
            assert : prependPrefix a ([] : List Text) ≡ ([] : List Text)
      }

in  prependPrefix
