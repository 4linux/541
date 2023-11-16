gcloud services enable compute.googleapis.com

export TF_VAR_project=lab-4linux-cka

export  ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -u ansible -i 34.151.198.8, --private-key ansible ../provision/ansible/kube-master.yaml 

ansible-playbook -u ansible -i 35.198.40.201, --private-key ansible provision/ansible/kube-master.yaml