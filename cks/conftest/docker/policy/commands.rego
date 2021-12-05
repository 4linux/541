package commands

denylist = [
  "apt",
  "pip",
  "curl",
  "wget",
]

deny[msg] {
  input[i].Cmd == "run"
  val := input[i].Value
  contains(val[_], denylist[_])
  msg = sprintf("Comandos não permitidos encontrads %s", [val])
}
