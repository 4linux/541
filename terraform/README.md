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

sudo apt install -y ansible rsync

ansible-playbook -u ansible -i 34.151.198.8, --private-key ansible ../provision/ansible/kube-master.yaml 

ansible-playbook -u ansible -i 35.198.40.201, --private-key ansible provision/ansible/kube-master.yaml

## k3s install

% multipass info k3s | grep -i ip
IPv4:           192.168.64.3
Mounts:         /Users/andersonbispos/Documents/workspaces/multipass/k3s => ~/k8s

multipass exec k3s sudo cat /var/lib/rancher/k3s/server/node-token

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.64.3:6443 K3S_TOKEN="K10161c604d616a3492edb0063b66c29671ab5e25fb8f811027270d88f29539659e::server:0bc0629292c16315ded4aa7593764da3" sh -

## bash completion

sudo apt-get install bash-completion -y

source /usr/share/bash-completion/bash_completion

echo 'source <(kubectl completion bash)' >>~/.bashrc

echo 'alias k=kubectl' >>~/.bashrc

echo 'complete -o default -F __start_kubectl k' >>~/.bashrc

## Comandos úteis gcloud

gcloud compute firewall-rules update allow-ssh --disabled

gcloud compute firewall-rules update allow-ssh --no-disabled

gcloud compute instances stop kube-node1 --zone=southamerica-east1-c

gcloud compute instances stop kube-master --zone=southamerica-east1-c

gcloud compute instances start kube-node1 --zone=southamerica-east1-c

gcloud compute instances start kube-master --zone=southamerica-east1-c  

gcloud config set accessibility/screen_reader False

## Referências

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion