# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :machine

    config.cache.auto_detect = false
    config.cache.enable :chef
    config.cache.enable :chef_gem
    config.cache.enable :yum
  end

  unless Vagrant.has_plugin?('vagrant-berkshelf')
    fail!('Please install vagrant-berkshelf to continue.')
  end

  config.berkshelf.enabled = true

  config.vm.box = 'chef/centos-6.6'
  config.vm.box_check_update = true

  config.vm.hostname = 'jenkins-plugins'
  config.vm.network 'forwarded_port', guest: '8080', host: '8080'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
    vb.cpus = 1
  end

  config.vm.provision 'chef_zero' do |chef|
    chef.install = true

    chef.json = {
      jenkins: {
        master: {
          version: '1.617-1.1'
        }
      }
    }

    chef.run_list = %w(
      recipe[jenkins_plugins::test]
    )
  end
end
