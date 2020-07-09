let Heap =
      let Unit = < TB | GB | MB | KB >

      in  { Type = { magnitude : Natural, unit : Unit }
          , Unit
          , TB = λ(magnitude : Natural) → { magnitude, unit = Unit.TB }
          , GB = λ(magnitude : Natural) → { magnitude, unit = Unit.GB }
          , MB = λ(magnitude : Natural) → { magnitude, unit = Unit.MB }
          , KB = λ(magnitude : Natural) → { magnitude, unit = Unit.KB }
          }

let render =
      let size =
            λ(heap : Heap.Type) →
              merge
                { TB = "${Natural/show heap.magnitude}t"
                , GB = "${Natural/show heap.magnitude}g"
                , MB = "${Natural/show heap.magnitude}m"
                , KB = "${Natural/show heap.magnitude}k"
                }
                heap.unit

      let xms = λ(value : Heap.Type) → "-Xms${size value}"

      let xmx = λ(value : Heap.Type) → "-Xmx${size value}"

      let fixed = λ(heap : Heap.Type) → "${xms heap} ${xmx heap}"

      let tests =
            { size = assert : size (Heap.KB 512) ≡ "512k"
            , xms = assert : xms (Heap.GB 4) ≡ "-Xms4g"
            , xmx = assert : xmx (Heap.GB 2) ≡ "-Xmx2g"
            , fixed = assert : fixed (Heap.MB 1024) ≡ "-Xms1024m -Xmx1024m"
            }

      in  { text = size, xms, xmx, fixed }

let exports = Heap ∧ { render }

in  exports
