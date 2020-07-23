let GitHub =
      let GitHub =
            { Type =
                { ssh-private-key : Text
                , api-token : Text
                , organization-name : Text
                }
            , default = {=}
            }

      in    GitHub
          ∧ { mock = GitHub::{
              , ssh-private-key = "mock"
              , api-token = "mock"
              , organization-name = "mock"
              }
            }

let ECR =
      let ECR =
            { Type =
                { aws-access-key-id : Text
                , aws-secret-access-key : Text
                , aws-region : Text
                }
            , default = {=}
            }

      in    ECR
          ∧ { mock = ECR::{
              , aws-access-key-id = "mock"
              , aws-secret-access-key = "mock"
              , aws-region = "mock"
              }
            }

let AWSAccount =
      let AWSAccount =
            { Type =
                { environment-variable-prefix : Text
                , access-key-id : Text
                , secret-access-key : Text
                }
            , default = {=}
            }

      in    AWSAccount
          ∧ { mock = AWSAccount::{
              , environment-variable-prefix = "MOCK"
              , access-key-id = "mock"
              , secret-access-key = "mock"
              }
            }

let Concourse =
      let Concourse = { Type = { common-webhook-token : Text }, default = {=} }

      in  Concourse ∧ { mock = Concourse::{ common-webhook-token = "mock" } }

let S3 =
      let S3 =
            { Type =
                { aws-access-key-id : Text
                , aws-secret-access-key : Text
                , aws-region : Text
                , release-bucket : Text
                }
            , default = {=}
            }

      in    S3
          ∧ { mock = S3::{
              , aws-access-key-id = "mock"
              , aws-secret-access-key = "mock"
              , aws-region = "mock"
              , release-bucket = "mock"
              }
            }

let Controller =
      let Controller =
            { Type =
                { aws-accounts : List AWSAccount.Type
                , concourse : Concourse.Type
                , ecr : ECR.Type
                , github : GitHub.Type
                , s3 : S3.Type
                }
            , default = {=}
            }

      in    Controller
          ∧ { mock = Controller::{
              , aws-accounts = [ AWSAccount.mock ]
              , concourse = Concourse.mock
              , ecr = ECR.mock
              , github = GitHub.mock
              , s3 = S3.mock
              }
            }

in  Controller ∧ { AWSAccount, Concourse, ECR, GitHub, S3 }
