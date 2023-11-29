# passo a passo pra preparação do ambiente na GCP

1. cria projeto

1. habilita api computing

    ```sh
    gcloud services enable compute.googleapis.com
    ```

1. coloca usuário de `service-<id-do-projeto>@compute-system.iam.gserviceaccount.com` no grupo instance admin

1. instala o ansible e rsync no cloud-shell

    ```sh
    sudo apt update; sudo apt install -y ansible rsync
    ```

1. clona o repositorio

    ```sh
    git clone https://github.com/4linux/4541.git
    ```

1. entra no diretorio

    ```sh
    cd 4541
    ```

1. faz checkout na branch gcp

    ```sh
    git checkout gcp
    ```

1. entra no diretorio terraform

    ```sh
    cd terraform
    ```

1. dentro do diretorio terraform, altera a permissão da chave ansible-key

    ```sh
    chmod 400 ansible-key
    ```

1. exporta a variable do terraform pra definir o nome do projeto

    ```sh
    export TF_VAR_project=lab-4linux-cka
    ```

1. valida que a variavel esta correta

    ```sh
    echo $TF_VAR_project
    ```

1. Inicializa o terraform

    ```sh
    terraform init
    ```


1. Inicializa o terraform

    ```sh
    terraform plan
    ```

1. Inicializa o terraform

    ```sh
    terraform apply -auto-approve

    ```

## bash completion

sudo apt-get install bash-completion -y

source /usr/share/bash-completion/bash_completion

echo 'source <(kubectl completion bash)' >>~/.bashrc

echo 'alias k=kubectl' >>~/.bashrc

echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc

## restore control plane

1. entra no diretorio

    ```sh
    cd 4541/terraform/
    ```

1. habilita o firewall

    ```sh
    gcloud compute firewall-rules update allow-ssh --no-disabled
    ```

1. faz um git pull

    ```sh
    git pull
    ```

1. copia o backup dos arquivos pro no1, usando o ip publico do nó

    ```sh
    scp -i ansible-key control-plane.tar.gz ansible@35.185.121.219:/tmp/
    ```

1. acessa o ssh do no1 e vira root

    ```sh
    cd /etc/kubernetes/manifests/
    ```

1. copia da pasta /tmp/ para /etc/kubernetes/manifests/

    ```sh
    cp /root/control-plane.tar.gz .
    ```

1. desempacota os arquivos

    ```sh
    tar xzvf control-plane.tar.gz
    ```

1. remove o backup

    ```sh
    rm control-plane.tar.gz
    ```

1. em outra janela testa o acesso ao cluster via kubectl

## Comandos úteis gcloud

gcloud config set accessibility/screen_reader False

gcloud config set compute/zone us-east1-c

gcloud compute firewall-rules list

gcloud compute firewall-rules update allow-ssh --disabled

gcloud compute firewall-rules update allow-ssh --no-disabled

gcloud compute firewall-rules update allow-node-port --disabled

gcloud compute firewall-rules update allow-node-port --no-disabled

gcloud compute firewall-rules create svc1 --network=cka-4linux --allow tcp:32439 --target-tags=kube-nodes

gcloud compute firewall-rules create svc2 --network=cka-4linux --allow tcp:31468 --target-tags=kube-nodes

gcloud compute firewall-rules create ingress --network=cka-4linux --allow tcp:31667 --target-tags=kube-nodes

gcloud compute instances list

gcloud compute ssh kube-master --tunnel-through-iap --zone=us-east1-c

gcloud compute instances stop kube-node1 --zone=southamerica-east1-c

gcloud compute instances stop kube-master --zone=southamerica-east1-c

gcloud compute instances start kube-node1 --zone=southamerica-east1-c

gcloud compute instances start kube-master --zone=southamerica-east1-c 

gcloud services enable compute.googleapis.com

## Referências

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion