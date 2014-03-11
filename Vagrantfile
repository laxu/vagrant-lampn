# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname    = 'webapp'
domain      = 'example.com'
ip          = "192.168.50.4"
cpus        = 1
ram         = 1024

Vagrant.configure("2") do |config|

    # Provider: VirtualBox (default)
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	# Provider: VMWare Workstation
	config.vm.provider :vmware_workstation do |v|
		config.vm.box = "precise64_vmware"
		config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
		v.vmx["memsize"] = ram
		v.vmx["numvcpus"] = cpus
	end

    config.vm.provider "virtualbox" do |v|
		v.customize [
			'modifyvm', :id,
			'--name', hostname,
			'--cpus', cpus,
			'--memory', ram,
			'--natdnshostresolver1', 'on',
			'--natdnsproxy1', 'on'
		]
    end
	
	# Common settings
	config.vm.host_name = (domain) ? hostname + '.' + domain : hostname
	config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network :private_network, ip: ip
    config.ssh.forward_agent = true
    config.vm.synced_folder ".", "/vagrant", :mount_options => [
        'dmode=777',
        'fmode=666'
    ]

	# Puppet provision
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'site.pp'
        puppet.module_path = 'puppet/modules'
    end

end