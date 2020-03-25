let imports = ../../../imports.dhall

let Kubernetes = imports.Kubernetes

let KubernetesUtils = imports.UtilityLibrary.kubernetes

let Settings = ./Settings.dhall

let Core =
      let common =
            let registry = "k8s.gcr.io"

            let tag = "0.6.1"

            let crd =
                  https://raw.githubusercontent.com/kubernetes/autoscaler/vertical-pod-autoscaler-0.6.3/vertical-pod-autoscaler/deploy/vpa-beta2-crd.yaml sha256:df36eca11d0c5ab145294439a1dbbf147a397f76163499eb750c6ca46bea46b3 as Text

            let resources =
                  Settings.Resources::{
                  , limits =
                      { cpu = KubernetesUtils.Compute.Millicpu 200
                      , memory = KubernetesUtils.Memory.MB 1000
                      }
                  , requests =
                      { cpu = KubernetesUtils.Compute.Millicpu 50
                      , memory = KubernetesUtils.Memory.MB 500
                      }
                  }

            in  { registry = registry
                , crd = crd
                , tag = tag
                , resources = resources
                }

      let AdmissionController =
              λ(tls : Settings.AdmissionController.TLS.Type)
            → Settings.AdmissionController::{
              , image =
                  KubernetesUtils.Image.Tag
                    { name = "vpa-admission-controller"
                    , tag = common.tag
                    , registry = common.registry
                    }
              , tls = tls
              , resources = common.resources
              }

      let Recommender =
            Settings.Recommender::{
            , image =
                KubernetesUtils.Image.Tag
                  { name = "vpa-recommender"
                  , tag = common.tag
                  , registry = common.registry
                  }
            , resources = common.resources
            }

      let Updater =
            Settings.Updater::{
            , image =
                KubernetesUtils.Image.Tag
                  { name = "vpa-updater"
                  , tag = common.tag
                  , registry = common.registry
                  }
            , resources = common.resources
            }

      in  { common = common
          , AdmissionController = AdmissionController
          , Recommender = Recommender
          , Updater = Updater
          }

in  Core
