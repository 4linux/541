# passo a passo pra preparação do ambiente na GCP

1. cria projeto
1. habilita api computing
1. coloca usuário de compute no grupo instance admin
1. instala o ansible no cloud-shell
1. exporta a variable do terraform pra definir o nome do projeto
1. roda o terraform

gcloud services enable compute.googleapis.com

export TF_VAR_project=lab-4linux-cka

export  ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -u ansible -i 34.151.198.8, --private-key ansible ../provision/ansible/kube-master.yaml 

ansible-playbook -u ansible -i 35.198.40.201, --private-key ansible provision/ansible/kube-master.yaml

## Comandos úteis gcloud

gcloud compute firewall-rules update allow-ssh --disabled

gcloud compute instances stop kube-node1 --zone=southamerica-east1-c

gcloud compute instances stop kube-master --zone=southamerica-east1-c

gcloud compute instances start kube-node1 --zone=southamerica-east1-c

gcloud compute instances start kube-master --zone=southamerica-east1-c

gcloud config set accessibility/screen_reader False