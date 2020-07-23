let Duration = < Seconds : Natural | Minutes : Natural | Hours : Natural >

let render =
      let render
          : ∀(value : Duration) → Text
          = λ(value : Duration) →
              merge
                { Seconds = λ(it : Natural) → "${Natural/show it}s"
                , Minutes = λ(it : Natural) → "${Natural/show it}m"
                , Hours = λ(it : Natural) → "${Natural/show it}h"
                }
                value

      let tests =
            { seconds = assert : render (Duration.Seconds 30) ≡ "30s"
            , minutes = assert : render (Duration.Minutes 60) ≡ "60m"
            , hours = assert : render (Duration.Hours 24) ≡ "24h"
            }

      in  render

let exports =
    {- the Seconds, Minutes, and Hours exports are provided as helpers.
    -- instead of needing to write:
     --     let Duration = ./Duration.dhall
     --     in Duration.Type.Seconds 30
     -- you can instead write:
     --     let Duration = ./Duration.dhall
     --     in Duration.Seconds 30
    -}
      { Type = Duration
      , Seconds = λ(value : Natural) → Duration.Seconds value
      , Minutes = λ(value : Natural) → Duration.Minutes value
      , Hours = λ(value : Natural) → Duration.Hours value
      , render
      }

in  exports
