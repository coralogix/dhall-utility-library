let Memory =
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
          : ∀(value : Memory) → Text
          =   λ(value : Memory)
            → merge
                { EB = λ(eb : Natural) → "${Natural/show eb}Ei"
                , PB = λ(pb : Natural) → "${Natural/show pb}Pi"
                , TB = λ(tb : Natural) → "${Natural/show tb}Ti"
                , GB = λ(gb : Natural) → "${Natural/show gb}Gi"
                , MB = λ(mb : Natural) → "${Natural/show mb}Mi"
                , KB = λ(kb : Natural) → "${Natural/show kb}Ki"
                , Bytes = λ(bytes : Natural) → Natural/show bytes
                }
                value

      let tests =
            { eb = assert : render (Memory.EB 10) ≡ "10Ei"
            , pb = assert : render (Memory.PB 10) ≡ "10Pi"
            , tb = assert : render (Memory.TB 10) ≡ "10Ti"
            , gb = assert : render (Memory.GB 10) ≡ "10Gi"
            , mb = assert : render (Memory.MB 10) ≡ "10Mi"
            , kb = assert : render (Memory.KB 10) ≡ "10Ki"
            , bytes = assert : render (Memory.Bytes 10) ≡ "10"
            }

      in  render

let exports =
    {- the EB, PB, TB, GB, MB, KB and Bytes exports are provided as helpers.
    -- instead of needing to write:
    --     let Memory = ./Memory.dhall
    --     in Memory.Type.MB 1024
    -- you can instead write:
    --     let Memory = ./Memory.dhall
    --     in Memory.MB 1024
    -}
      { Type = Memory
      , EB = λ(value : Natural) → Memory.EB value
      , PB = λ(value : Natural) → Memory.PB value
      , TB = λ(value : Natural) → Memory.TB value
      , GB = λ(value : Natural) → Memory.GB value
      , MB = λ(value : Natural) → Memory.MB value
      , KB = λ(value : Natural) → Memory.KB value
      , Bytes = λ(value : Natural) → Memory.Bytes value
      , render = render
      }

in  exports
