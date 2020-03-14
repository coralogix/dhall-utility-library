let Level = < All | Debug | Info | Warn | Error | None > : Type

let render =
      let render
          : ∀(value : Level) → Text
          =   λ(value : Level)
            → merge
                { All = "all"
                , Debug = "debug"
                , Info = "info"
                , Warn = "warn"
                , Error = "error"
                , None = "none"
                }
                value
      
      let tests =
            { all = assert : render Level.All ≡ "all"
            , debug = assert : render Level.Debug ≡ "debug"
            , info = assert : render Level.Info ≡ "info"
            , warn = assert : render Level.Warn ≡ "warn"
            , error = assert : render Level.Error ≡ "error"
            , none = assert : render Level.None ≡ "none"
            }
      
      in  render

let exports =
    {- the All, Debug, Info, Warn, Error and None exports are provided as helpers.
    -- instead of needing to write:
      --     let Level = ./Level.dhall
      --     in Level.Type.All
      -- you can instead write:
      --     let level = ./Level.dhall
      --     in Level.All
      -}
      { Type = Level
      , All = Level.All
      , Debug = Level.Debug
      , Info = Level.Info
      , Warn = Level.Warn
      , Error = Level.Error
      , None = Level.None
      , render = render
      }

in  exports
