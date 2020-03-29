let Compute = < Millicpu : Natural | Cpu : Natural >

let render =
      let render
          : ∀(value : Compute) → Text
          =   λ(value : Compute)
            → merge
                { Millicpu = λ(it : Natural) → "${Natural/show it}m"
                , Cpu = λ(it : Natural) → "${Natural/show it}"
                }
                value

      let tests =
            { millicpu = assert : render (Compute.Millicpu 1000) ≡ "1000m"
            , cpu = assert : render (Compute.Cpu 1) ≡ "1"
            }

      in  render

let exports =
    {- the Millicpu, Cpu exports are provided as helpers.
    -- instead of needing to write:
      --     let Compute = ./Compute.dhall
      --     in Compute.Type.Millicpu 1000
      -- you can instead write:
      --     let Compute = ./Compute.dhall
      --     in Compute.Millicpu 1000
      -}
      { Type = Compute
      , Millicpu = λ(value : Natural) → Compute.Millicpu value
      , Cpu = λ(value : Natural) → Compute.Cpu value
      , render = render
      }

in  exports
