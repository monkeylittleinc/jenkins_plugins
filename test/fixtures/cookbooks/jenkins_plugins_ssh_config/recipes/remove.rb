jenkins_plugins_ssh_config 'bitbucket.org'

jenkins_plugins_ssh_config 'github.com'

jenkins_plugins_ssh_config 'bitbucket.org' do
  action :remove
end
