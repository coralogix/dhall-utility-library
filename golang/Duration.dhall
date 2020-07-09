let Duration =
      let Unit = < Seconds | Minutes | Hours >

      in  { Type = { unit : Unit, magnitude : Natural }
          , Unit
          , Seconds =
              λ(magnitude : Natural) → { magnitude, unit = Unit.Seconds }
          , Minutes =
              λ(magnitude : Natural) → { magnitude, unit = Unit.Minutes }
          , Hours = λ(magnitude : Natural) → { magnitude, unit = Unit.Hours }
          }

let render =
      let render
          : ∀(value : Duration.Type) → Text
          = λ(value : Duration.Type) →
              merge
                { Seconds = "${Natural/show value.magnitude}s"
                , Minutes = "${Natural/show value.magnitude}m"
                , Hours = "${Natural/show value.magnitude}h"
                }
                value.unit

      let tests =
            { seconds = assert : render (Duration.Seconds 30) ≡ "30s"
            , minutes = assert : render (Duration.Minutes 60) ≡ "60m"
            , hours = assert : render (Duration.Hours 24) ≡ "24h"
            }

      in  render

let exports = Duration ∧ { render }

in  exports
