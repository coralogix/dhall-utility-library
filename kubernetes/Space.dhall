let Space =
      let Unit = < EB | PB | TB | GB | MB | KB | Bytes >

      in  { Type = { magnitude : Natural, unit : Unit }
          , Unit
          , EB = λ(magnitude : Natural) → { magnitude, unit = Unit.EB }
          , PB = λ(magnitude : Natural) → { magnitude, unit = Unit.PB }
          , TB = λ(magnitude : Natural) → { magnitude, unit = Unit.TB }
          , GB = λ(magnitude : Natural) → { magnitude, unit = Unit.GB }
          , MB = λ(magnitude : Natural) → { magnitude, unit = Unit.MB }
          , KB = λ(magnitude : Natural) → { magnitude, unit = Unit.KB }
          , Bytes = λ(magnitude : Natural) → { magnitude, unit = Unit.Bytes }
          }

let render =
      let render
          : ∀(value : Space.Type) → Text
          = λ(value : Space.Type) →
              merge
                { EB = "${Natural/show value.magnitude}Ei"
                , PB = "${Natural/show value.magnitude}Pi"
                , TB = "${Natural/show value.magnitude}Ti"
                , GB = "${Natural/show value.magnitude}Gi"
                , MB = "${Natural/show value.magnitude}Mi"
                , KB = "${Natural/show value.magnitude}Ki"
                , Bytes = Natural/show value.magnitude
                }
                value.unit

      let tests =
            { eb = assert : render (Space.EB 1) ≡ "1Ei"
            , pb = assert : render (Space.PB 1) ≡ "1Pi"
            , tb = assert : render (Space.TB 1) ≡ "1Ti"
            , gb = assert : render (Space.GB 10) ≡ "10Gi"
            , mb = assert : render (Space.MB 100) ≡ "100Mi"
            , kb = assert : render (Space.KB 1024) ≡ "1024Ki"
            , bytes = assert : render (Space.Bytes 128) ≡ "128"
            }

      in  render

let exports = Space ∧ { render }

in  exports
