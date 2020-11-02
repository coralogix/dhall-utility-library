let imports = ../imports.dhall

let Prelude = imports.Prelude

let Resources =
      { Type = { cpu : Optional Text, memory : Optional Text }
      , default = { cpu = None Text, memory = None Text }
      }

in  λ(limits : Optional Resources.Type) →
      let foldedlimits =
            Prelude.Optional.default Resources.Type Resources::{=} limits

      let cpu =
            merge
              { Some = λ(cpu : Text) → toMap { cpu }
              , None = [] : Prelude.Map.Type Text Text
              }
              foldedlimits.cpu

      let memory =
            merge
              { Some = λ(memory : Text) → toMap { memory }
              , None = [] : Prelude.Map.Type Text Text
              }
              foldedlimits.memory

      in  Some (memory # cpu)
