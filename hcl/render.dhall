let imports = ../imports.dhall

let Prelude = imports.Prelude

let JSON = Prelude.JSON

let Duration = ../golang/Duration.dhall

in  { helpers.json.optional =
        let generic =
              λ(input : Type) →
              λ(render : input → JSON.Type) →
              λ(it : Optional input) →
                merge
                  { Some = λ(value : input) → render value, None = JSON.null }
                  it

        in  { generic
            , duration =
                generic
                  Duration.Type
                  ( Prelude.Function.compose
                      Duration.Type
                      Text
                      JSON.Type
                      Duration.render
                      JSON.string
                  )
            , text = generic Text JSON.string
            , natural =
                generic
                  Natural
                  ( Prelude.Function.compose
                      Natural
                      Text
                      JSON.Type
                      Natural/show
                      JSON.string
                  )
            , bool =
                generic
                  Bool
                  ( Prelude.Function.compose
                      Bool
                      Text
                      JSON.Type
                      (λ(value : Bool) → if value then "true" else "false")
                      JSON.string
                  )
            }
    }
