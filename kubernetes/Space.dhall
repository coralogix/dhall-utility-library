let Space =
      < EB : Natural
      | PB : Natural
      | TB : Natural
      | GB : Natural
      | MB : Natural
      | KB : Natural
      | Bytes : Natural
      >

let render =
      let render
          : ∀(value : Space) → Text
          = λ(value : Space) →
              merge
                { EB = λ(it : Natural) → "${Natural/show it}Ei"
                , PB = λ(it : Natural) → "${Natural/show it}Pi"
                , TB = λ(it : Natural) → "${Natural/show it}Ti"
                , GB = λ(it : Natural) → "${Natural/show it}Gi"
                , MB = λ(it : Natural) → "${Natural/show it}Mi"
                , KB = λ(it : Natural) → "${Natural/show it}Ki"
                , Bytes = λ(it : Natural) → Natural/show it
                }
                value

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

let exports =
    {- the EB, PB, TB, GB, MB, KB and Bytes exports are provided as helpers.
    -- instead of needing to write:
      --     let Space = ./Space.dhall
      --     in Space.Type.GB 100
      -- you can instead write:
      --     let Space = ./Space.dhall
      --     in Space.GB 100
      -}
      { Type = Space
      , EB = λ(value : Natural) → Space.EB value
      , PB = λ(value : Natural) → Space.PB value
      , TB = λ(value : Natural) → Space.TB value
      , GB = λ(value : Natural) → Space.GB value
      , MB = λ(value : Natural) → Space.MB value
      , KB = λ(value : Natural) → Space.KB value
      , Bytes = λ(value : Natural) → Space.Bytes value
      , render
      }

in  exports
