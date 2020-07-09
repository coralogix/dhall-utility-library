{ golang =
      ./golang/package.dhall sha256:d9502bfa7c143945ee41140fdafcbf1c21ac44d2388632571f70085ccf2414bf
    ? ./golang/package.dhall
, hcl =
      ./hcl/package.dhall sha256:4fd384a427365c554a88cd58c02d4d03a772213b591664028797fdddb276681d
    ? ./hcl/package.dhall
, kubernetes =
      ./kubernetes/package.dhall sha256:6f0b756217bc724e4fadedca2875cd7a469404c1c47a30e8716e59932dd37561
    ? ./kubernetes/package.dhall
, log =
      ./log/package.dhall sha256:4602b9f70fdcd8de5169cffbe11870a851b69d56b1c4a4525b2c8df289ef8db5
    ? ./log/package.dhall
, map =
      ./map/package.dhall sha256:e3dd5145bac09f9480664b35dcff007967e993ea5233ba7994404b7aaf62b92b
    ? ./map/package.dhall
, jvm =
      ./jvm/package.dhall sha256:32a26cebf4ba9425fe1fd35e1079d52f01460209012cbfece97593bacff6db01
    ? ./jvm/package.dhall
}
