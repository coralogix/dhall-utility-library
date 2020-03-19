let Options =
      let Tag =
            { Type = { name : Text, tag : Text, registry : Text }
            , default = {=}
            }

      let Sha256 =
            { Type = { name : Text, hash : Text, registry : Text }
            , default = {=}
            }

      in  { Tag = Tag, Sha256 = Sha256 }

let Image = < Tag : Options.Tag.Type | Sha256 : Options.Sha256.Type >

let render =
      let render
          : ∀(value : Image) → Text
          =   λ(value : Image)
            → merge
                { Tag =
                      λ(it : Options.Tag.Type)
                    → "${it.registry}/${it.name}:${it.tag}"
                , Sha256 =
                      λ(it : Options.Sha256.Type)
                    → "${it.registry}/${it.name}@sha256:${it.hash}"
                }
                value

      let tests =
            { tag =
                  assert
                :   render
                      ( Image.Tag
                          Options.Tag::{
                          , name = "myimage"
                          , tag = "v0.1.0"
                          , registry = "myecr"
                          }
                      )
                  ≡ "myecr/myimage:v0.1.0"
            , sha256 =
                  assert
                :   render
                      ( Image.Sha256
                          Options.Sha256::{
                          , name = "myimage"
                          , hash =
                              "f397104c7ce7d9564192366859208edce8b12583e78f79d760749ac57b9fadc0"
                          , registry = "myecr"
                          }
                      )
                  ≡ "myecr/myimage@sha256:f397104c7ce7d9564192366859208edce8b12583e78f79d760749ac57b9fadc0"
            }

      in  render

let exports =
    {- the Tag and Sha256 exports are provided as helpers.
    -- instead of needing to write:
      --     let Image = ./Image.dhall
      --     in Image.Type.Tag { name = "myimage", tag = "v0.1.0", registry = "ecr"}
      -- you can instead write:
      --     let Image = ./Image.dhall
      --     in Image.Tag { name = "myimage", tag = "v0.1.0", registry = "ecr" }
      -}
      { Type = Image
      , Tag = λ(value : Options.Tag.Type) → Image.Tag value
      , Sha256 = λ(value : Options.Sha256.Type) → Image.Sha256 value
      , Options = Options
      , render = render
      }

in  exports
