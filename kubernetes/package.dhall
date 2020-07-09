{ Duration =
    let import =
        {- Duration was moved from `kubernetes` to `golang` to accommodate
        -- the fact that other projects written in Golang use the same
        -- Go-standard parsing library, but those projects aren't
        -- Kubernetes projects.
        -- This import is maintained here so that downstream doesn't need to
        -- update from `kubernetes.Duration` to `golang.Duration`.
        -}
            ../golang/Duration.dhall sha256:1396fea99606ea308ac050de3c2c071489f1eb4287aff271c28968b5e271fb1a
          ? ../golang/Duration.dhall

    in  import
, Image =
      ./Image.dhall sha256:62d2eba8a654705779b2c947298698d8b93f5127b9c6f887ed9b526cae5cb757
    ? ./Image.dhall
, Compute =
      ./Compute.dhall sha256:eae72b0977cc2348ea5f96010839bc4bdac95d56a6ba452678003836bf09fd0c
    ? ./Compute.dhall
, Space =
      ./Space.dhall sha256:4bd705ca605d92dbde68cada44e0dbef5ea2a437adad0b2ac47f7af8b18578dc
    ? ./Space.dhall
, Memory =
      ./Memory.dhall sha256:4bd705ca605d92dbde68cada44e0dbef5ea2a437adad0b2ac47f7af8b18578dc
    ? ./Memory.dhall
}
