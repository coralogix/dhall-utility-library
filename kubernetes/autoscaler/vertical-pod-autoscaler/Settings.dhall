let imports = ../../../imports.dhall

let Kubernetes = imports.Kubernetes

let KubernetesUtils = imports.UtilityLibrary.kubernetes

let Resources =
      let Resources =
            { limits :
                { cpu : KubernetesUtils.Compute.Type
                , memory : KubernetesUtils.Memory.Type
                }
            , requests :
                { cpu : KubernetesUtils.Compute.Type
                , memory : KubernetesUtils.Memory.Type
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
                            KubernetesUtils.Compute.render resources.limits.cpu
                        , memory =
                            KubernetesUtils.Memory.render
                              resources.limits.memory
                        }
                    )
                , requests = Some
                    ( toMap
                        { cpu =
                            KubernetesUtils.Compute.render
                              resources.requests.cpu
                        , memory =
                            KubernetesUtils.Memory.render
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
              , image : KubernetesUtils.Image.Type
              , resources : Resources.Type
              }
          , default.enabled = True
          , TLS = TLS
          }

let Recommender =
      { Type =
          { image : KubernetesUtils.Image.Type, resources : Resources.Type }
      , default = {=}
      }

let Updater =
      { Type =
          { enabled : Bool
          , image : KubernetesUtils.Image.Type
          , resources : Resources.Type
          }
      , default.enabled = True
      }

in  { Type =
        { crd : Text
        , admission-controller : AdmissionController.Type
        , recommender : Recommender.Type
        , updater : Updater.Type
        }
    , default = { recommender = Recommender.default, updater = Updater.default }
    , Resources = Resources
    , AdmissionController = AdmissionController
    , Recommender = Recommender
    , Updater = Updater
    }
