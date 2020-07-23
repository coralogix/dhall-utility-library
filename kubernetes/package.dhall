{ Duration =
    let import =
        {- Duration was moved from `kubernetes` to `golang` to accommodate
        -- the fact that other projects written in Golang use the same
        -- Go-standard parsing library, but those projects aren't
        -- Kubernetes projects.
        -- This import is maintained here so that downstream doesn't need to
        -- update from `kubernetes.Duration` to `golang.Duration`.
        -}
            ../golang/Duration.dhall sha256:86ef3afe9f504f1827a8a0e502cbb43317f39f0f6ecd7a1ac939ddf32d93903f
          ? ../golang/Duration.dhall

    in  import
, Image =
      ./Image.dhall sha256:62d2eba8a654705779b2c947298698d8b93f5127b9c6f887ed9b526cae5cb757
    ? ./Image.dhall
, Compute =
      ./Compute.dhall sha256:e36235133fc356a2a02046dae7c4a3003b100b770b5b7e2fd02977c523c52181
    ? ./Compute.dhall
, Space =
      ./Space.dhall sha256:57a3eea389c5d6a940103c0885e3b4f9c3d6a070edd3515fc71115f7f37365b1
    ? ./Space.dhall
, Memory =
      ./Memory.dhall sha256:57a3eea389c5d6a940103c0885e3b4f9c3d6a070edd3515fc71115f7f37365b1
    ? ./Memory.dhall
}
