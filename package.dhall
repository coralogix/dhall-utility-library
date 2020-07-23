{ golang =
      ./golang/package.dhall sha256:ed66ebc3dbbf54b17d2233c97f6341184ae73a5c233c72e7cf5ccd028e7440de
    ? ./golang/package.dhall
, hcl =
      ./hcl/package.dhall sha256:8097abc6db4887e9599462240e8319eee77372de3f147fca35a3f300677ff5ff
    ? ./hcl/package.dhall
, kubernetes =
      ./kubernetes/package.dhall sha256:f67d9c188f1153923b4a3b50b12bef4bd1a0cf7f2032ca79f677a106e8cda606
    ? ./kubernetes/package.dhall
, log =
      ./log/package.dhall sha256:4602b9f70fdcd8de5169cffbe11870a851b69d56b1c4a4525b2c8df289ef8db5
    ? ./log/package.dhall
, map =
      ./map/package.dhall sha256:e3dd5145bac09f9480664b35dcff007967e993ea5233ba7994404b7aaf62b92b
    ? ./map/package.dhall
, jvm =
      ./jvm/package.dhall sha256:c38453f844ce7897650c79d15d8cf62ace7eadc4310457e23a94caa13819eedc
    ? ./jvm/package.dhall
, controller =
      ./controller/package.dhall sha256:af4e0084a475c10ec9b0d26317765832ed6125cba5bd379b30ea7ddd06aab78e
    ? ./controller/package.dhall
}
