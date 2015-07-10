include_recipe 'jenkins_plugins_git::install'

include_recipe 'jenkins_plugins_maven::install'

include_recipe 'jenkins_plugins_ssh_key::add'

include_recipe 'jenkins_plugins_ssh_config::add'

include_recipe 'jenkins_plugins_workflow::create'
