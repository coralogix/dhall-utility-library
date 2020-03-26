let Heap = < TB : Natural | GB : Natural | MB : Natural | KB : Natural >

let render =
      let size =
              λ(heap : Heap)
            → merge
                { TB = λ(size : Natural) → "${Natural/show size}t"
                , GB = λ(size : Natural) → "${Natural/show size}g"
                , MB = λ(size : Natural) → "${Natural/show size}m"
                , KB = λ(size : Natural) → "${Natural/show size}k"
                }
                heap

      let xms = λ(value : Heap) → "-Xms${size value}"

      let xmx = λ(value : Heap) → "-Xmx${size value}"

      let fixed = λ(heap : Heap) → "${xms heap} ${xmx heap}"

      let tests =
            { size = assert : size (Heap.KB 512) ≡ "512k"
            , xms = assert : xms (Heap.GB 4) ≡ "-Xms4g"
            , xmx = assert : xmx (Heap.GB 2) ≡ "-Xmx2g"
            , fixed = assert : fixed (Heap.MB 1024) ≡ "-Xms1024m -Xmx1024m"
            }

      in  { text = size, xms = xms, xmx = xmx, fixed = fixed }

let exports =
    {- the TB, GB, MB, KB exports are provided as helpers.
    -- instead of needing to write :
    --      let Heap = ./Heap.dhall
    --      in Heap.Type.GB 2
    -- you can instead write
    --      let Heap = ./Heap.dhall
    --      in Heap.GB 2
    -}
      { Types = Heap
      , render = render
      , TB = λ(value : Natural) → Heap.TB value
      , GB = λ(value : Natural) → Heap.GB value
      , MB = λ(value : Natural) → Heap.MB value
      , KB = λ(value : Natural) → Heap.KB value
      }

in  exports
