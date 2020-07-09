let Compute =
      let Unit = < Millicpu | Cpu >

      in  { Type = { magnitude : Natural, unit : Unit }
          , Unit
          , Millicpu =
              λ(magnitude : Natural) → { magnitude, unit = Unit.Millicpu }
          , Cpu = λ(magnitude : Natural) → { magnitude, unit = Unit.Cpu }
          }

let render =
      let render
          : ∀(value : Compute.Type) → Text
          = λ(value : Compute.Type) →
              merge
                { Millicpu = "${Natural/show value.magnitude}m"
                , Cpu = "${Natural/show value.magnitude}"
                }
                value.unit

      let tests =
            { millicpu = assert : render (Compute.Millicpu 1000) ≡ "1000m"
            , cpu = assert : render (Compute.Cpu 1) ≡ "1"
            }

      in  render

let exports = Compute ∧ { render }

in  exports
