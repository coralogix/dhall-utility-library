let imports = ../imports.dhall

let Kubernetes = imports.Kubernetes

let KubeUtils = imports.KubeUtils

let Resources =
      let Resources =
            { limits :
                { cpu : KubeUtils.Resources.Compute.Types
                , memory : KubeUtils.Resources.Memory.Types
                }
            , requests :
                { cpu : KubeUtils.Resources.Compute.Types
                , memory : KubeUtils.Resources.Memory.Types
                }
            }

      in  { Type = Resources
          , default = {=}
          , render.kubernetes-resource-requirements =
                λ(resources : Resources)
              → Kubernetes.ResourceRequirements::{
                , limits = Some
                    ( toMap
                        { cpu =
                            KubeUtils.Resources.Compute.render
                              resources.limits.cpu
                        , memory =
                            KubeUtils.Resources.Memory.render
                              resources.limits.memory
                        }
                    )
                , requests = Some
                    ( toMap
                        { cpu =
                            KubeUtils.Resources.Compute.render
                              resources.requests.cpu
                        , memory =
                            KubeUtils.Resources.Memory.render
                              resources.requests.memory
                        }
                    )
                }
          }

let AdmissionController =
      let TLS =
            { Type =
                { certificate-authority-private-key : Text
                , certificate-authority-public-certificate : Text
                , server-private-key : Text
                , server-public-certificate : Text
                }
            , default = {=}
            }

      in  { Type =
              { enabled : Bool
              , tls : TLS.Type
              , image : KubeUtils.Image.Types
              , resources : Resources.Type
              }
          , default =
              { enabled = True
              , image =
                  KubeUtils.Image.Types.Tag
                    { name = "k8s.gcr.io/vpa-admission-controller"
                    , tag = "0.6.1"
                    }
              , resources = Resources::{
                , limits =
                    { cpu = KubeUtils.Resources.Compute.Types.Milicpu 200
                    , memory = KubeUtils.Resources.Memory.Types.MB 500
                    }
                , requests =
                    { cpu = KubeUtils.Resources.Compute.Types.Milicpu 50
                    , memory = KubeUtils.Resources.Memory.Types.MB 200
                    }
                }
              }
          , TLS = TLS
          }

let Recommender =
      { Type = { image : KubeUtils.Image.Types, resources : Resources.Type }
      , default =
          { image =
              KubeUtils.Image.Types.Tag
                { name = "k8s.gcr.io/vpa-recommender", tag = "0.6.1" }
          , resources = Resources::{
            , limits =
                { cpu = KubeUtils.Resources.Compute.Types.Milicpu 200
                , memory = KubeUtils.Resources.Memory.Types.MB 1000
                }
            , requests =
                { cpu = KubeUtils.Resources.Compute.Types.Milicpu 50
                , memory = KubeUtils.Resources.Memory.Types.MB 500
                }
            }
          }
      }

let Updater =
      { Type =
          { enabled : Bool
          , image : KubeUtils.Image.Types
          , resources : Resources.Type
          }
      , default =
          { enabled = True
          , image =
              KubeUtils.Image.Types.Tag
                { name = "k8s.gcr.io/vpa-updater", tag = "0.6.1" }
          , resources = Resources::{
            , limits =
                { cpu = KubeUtils.Resources.Compute.Types.Milicpu 200
                , memory = KubeUtils.Resources.Memory.Types.MB 1000
                }
            , requests =
                { cpu = KubeUtils.Resources.Compute.Types.Milicpu 50
                , memory = KubeUtils.Resources.Memory.Types.MB 500
                }
            }
          }
      }

in  { Type =
        { crd : Text
        , admission-controller : AdmissionController.Type
        , recommender : Recommender.Type
        , updater : Updater.Type
        }
    , default =
        { crd =
            https://raw.githubusercontent.com/kubernetes/autoscaler/vertical-pod-autoscaler-0.6.3/vertical-pod-autoscaler/deploy/vpa-beta2-crd.yaml sha256:df36eca11d0c5ab145294439a1dbbf147a397f76163499eb750c6ca46bea46b3 as Text
        , recommender = Recommender.default
        , updater = Updater.default
        }
    , Resources = Resources
    , AdmissionController = AdmissionController
    , Recommender = Recommender
    , Updater = Updater
    }
