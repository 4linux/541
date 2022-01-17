# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

vms = {
  'kube-master' => {'memory' => '3584', 'cpus' => 1, 'ip' => '100', 'box' => 'devopsbox/ubuntu-20.04-docker', 'provision' => 'provision/ansible/kube-master.yaml'},
  'kube-node1' => {'memory' => '1536', 'cpus' => 1, 'ip' => '101', 'box' => 'devopsbox/ubuntu-20.04-docker','provision' => 'provision/ansible/kube-node1.yaml'},
  'kube-node2' => {'memory' => '1536', 'cpus' => 1, 'ip' => '102', 'box' => 'devopsbox/ubuntu-20.04-docker', 'provision' => 'provision/ansible/kube-node2.yaml'},
  'kube-registry' => {'memory' => '512', 'cpus' => 1, 'ip' => '103', 'box' => 'devopsbox/ubuntu-20.04-docker', 'provision' => 'provision/ansible/kube-registry.yaml'}
}

Vagrant.configure('2') do |config|

  config.vm.box_check_update = false

        if !(File.exists?('id_rsa'))
          system("ssh-keygen -b 2048 -t rsa -f id_rsa -q -N ''")
       end

  vms.each do |name, conf|
    config.vm.define "#{name}" do |k|
      k.vm.box = "#{conf['box']}"
      k.vm.hostname = "#{name}"
      k.vm.network 'private_network', ip: "172.16.1.#{conf['ip']}"
      k.vm.provider 'virtualbox' do |vb|
        vb.memory = conf['memory']
        vb.cpus = conf['cpus']
      end
      k.vm.provision 'ansible_local' do |ansible|
        ansible.playbook = "#{conf['provision']}"
        ansible.compatibility_mode = '2.0'
      end
    end
  end
end
