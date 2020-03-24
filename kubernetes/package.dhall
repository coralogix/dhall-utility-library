{ Duration =
    let import =
        {- Duration was moved from `kubernetes` to `golang` to accommodate
        -- the fact that other projects written in Golang use the same
        -- Go-standard parsing library, but those projects aren't
        -- Kubernetes projects.
        -- This import is maintained here so that downstream doesn't need to
        -- update from `kubernetes.Duration` to `golang.Duration`.
        -}
          ../golang/Duration.dhall

    in  import
, Image = ./Image.dhall
, Compute = ./Compute.dhall
, Space = ./Space.dhall
, Memory = ./Memory.dhall
}
