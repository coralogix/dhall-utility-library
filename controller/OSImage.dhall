let imports = ../imports.dhall

let Kops = imports.Kops.api.v1alpha2

let Region = imports.AWS.map.Region

let OSImage = < UbuntuFocal >

let kops_ami_filter
    : ∀(image : OSImage) → Text
    = λ(image : OSImage) →
        merge
          { UbuntuFocal =
              "099720109477/ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20200423"
          }
          image

let ca-cert-bundle-location
    : ∀(image : OSImage) → Text
    = λ(image : OSImage) →
        merge { UbuntuFocal = "/etc/ssl/certs/ca-certificates.crt" } image

let iptables-legacy-mode-workaround
    : ∀(image : OSImage) → Optional Kops.UserData.Type
    = λ(image : OSImage) →
        let common =
              Kops.UserData::{
              , name = "iptables-xfs.sh"
              , type = "text/x-shellscript"
              , content =
                  ''
                  #!/bin/sh
                  apt-get update -y && apt-get install -y arptables ebtables xfsprogs
                  update-alternatives --set iptables /usr/sbin/iptables-legacy
                  update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
                  update-alternatives --set arptables /usr/sbin/arptables-legacy
                  update-alternatives --set ebtables /usr/sbin/ebtables-legacy
                  ''
              }

        in  merge { UbuntuFocal = Some common } image

in  { Type = OSImage
    , UbuntuFocal = OSImage.UbuntuFocal
    , kops_ami_filter
    , ca-cert-bundle-location
    , iptables-legacy-mode-workaround
    }
