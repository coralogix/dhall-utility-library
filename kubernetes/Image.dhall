let Image =
      < Tag : { name : Text, tag : Text }
      | Sha256 : { name : Text, hash : Text }
      >

let render =
      let render
          : ∀(value : Image) → Text
          =   λ(value : Image)
            → merge
                { Tag =
                    λ(it : { name : Text, tag : Text }) → "${it.name}:${it.tag}"
                , Sha256 =
                      λ(it : { name : Text, hash : Text })
                    → "${it.name}@sha256:${it.hash}"
                }
                value
      
      let tests =
            { tag =
                  assert
                :   render (Image.Tag { name = "myimage", tag = "v0.1.0" })
                  ≡ "myimage:v0.1.0"
            , sha256 =
                  assert
                :   render
                      ( Image.Sha256
                          { name =
                              "myimage"
                          , hash =
                              "f397104c7ce7d9564192366859208edce8b12583e78f79d760749ac57b9fadc0"
                          }
                      )
                  ≡ "myimage@sha256:f397104c7ce7d9564192366859208edce8b12583e78f79d760749ac57b9fadc0"
            }
      
      in  render

let exports =
    {- the Tag and Sha256 exports are provided as helpers.
    -- instead of needing to write:
      --     let Image = ./Image.dhall
      --     in Image.Type.Tag { name = "myimage", tag = "v0.1.0" }
      -- you can instead write:
      --     let Image = ./Image.dhall
      --     in Image.Tag { name = "myimage", tag = "v0.1.0" }
      -}
      { Type = Image
      , Tag = λ(value : { name : Text, tag : Text }) → Image.Tag value
      , Sha256 = λ(value : { name : Text, hash : Text }) → Image.Sha256 value
      , render = render
      }

in  exports
