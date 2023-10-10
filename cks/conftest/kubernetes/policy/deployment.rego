package main

deny[msg] {
  input.kind == "Deployment"
  not input.spec.selector.matchLabels.app
  msg := "Os containers devem fornecer labels de aplicativo para seletores de Pod"
}

deny[msg] {
  input.kind = "Deployment"
  not input.spec.template.spec.securityContext.readOnlyRootFilesystem = true
  msg = "Os containers devem ser executados com sistema de arquivos somente leitura"
}

deny[msg] {
  input.kind = "Deployment"
  not input.spec.template.spec.securityContext.runAsNonRoot = true
  msg = "Os containers não devem ser executados com root"
}

deny[msg] {
  input.kind == "Deployment"
  image := input.spec.template.spec.containers[_].image
  endswith(image, "latest")
  msg := sprintf("A imagem '%v' esta usando a tag latest", [image])
}

deny[msg] {

  input.kind == "Deployment"
  image := input.spec.template.spec.containers[_].image
  not startswith(image, "registry:5000/")
  msg := sprintf("A imagem '%v' nao esta informando a url do repositorio registry:5000", [image])
}
