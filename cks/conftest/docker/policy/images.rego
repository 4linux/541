package main

denylist = ["ubuntu"]

deny[msg] {
  input[i].Cmd == "from"
  val := input[i].Value
  contains(val[i], denylist[_])
  msg = sprintf("Imagem não permitida encontada %s", [val])
}
