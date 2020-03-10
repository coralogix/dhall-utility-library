let imports = ../imports.dhall

let Prelude = imports.Prelude

let build-from-render-and-optional
    :   ∀(input : Type)
      → ∀(output : Type)
      → ∀(render : input → output)
      → ∀(key : Text)
      → ∀(value : Optional input)
      → Prelude.Map.Type Text output
    =
      {- build-from-render-and-optional helps to create Maps
      -- from pairings of keys, rendering functions, and optionals.
      -- It relies upon Dhall's currying properties to expressively
      -- assemble the output maps from just the keys and optionals.
      -}
        λ(input : Type)
      → λ(output : Type)
      → λ(render : input → output)
      → λ(key : Text)
      → λ(value : Optional input)
      → Prelude.Optional.fold
          input
          value
          (Prelude.Map.Type Text output)
          (   λ(value : input)
            → [ Prelude.Map.keyValue output key (render value) ]
          )
          (Prelude.Map.empty Text output)

let test =
      let Illustrative =
            let Illustrative = < Foo | Bar >

            in  { Type = Illustrative
                , Foo = Illustrative.Foo
                , Bar = Illustrative.Bar
                , render =
                      λ(value : Illustrative)
                    → merge { Foo = "foo", Bar = "bar" } value
                }

      in  { example =
              let build =
                    build-from-render-and-optional
                      Illustrative.Type
                      Text
                      Illustrative.render

              let record =
                    { foo = Some Illustrative.Foo
                    , bar = Some Illustrative.Bar
                    , baz = None Illustrative.Type
                    }

              in    assert
                  :   (   build "FOO" record.foo
                        # build "BAR" record.bar
                        # build "BAZ" record.baz
                      )
                    ≡ [ Prelude.Map.keyText "FOO" "foo"
                      , Prelude.Map.keyText "BAR" "bar"
                      ]
          , empty =
              let build =
                    build-from-render-and-optional
                      Illustrative.Type
                      Text
                      Illustrative.render

              let record =
                    { foo = None Illustrative.Type
                    , bar = None Illustrative.Type
                    , baz = None Illustrative.Type
                    }

              in    assert
                  :   (   build "FOO" record.foo
                        # build "BAR" record.bar
                        # build "BAZ" record.baz
                      )
                    ≡ Prelude.Map.empty Text Text
          }

in  build-from-render-and-optional
