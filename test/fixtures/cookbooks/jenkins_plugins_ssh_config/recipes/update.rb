jenkins_plugins_ssh_config 'bitbucket.org' do
  options({
    'Hostname' => 'altssh.bitbucket.org',
    'Port' => '443',
    'IdentityFile' => '/var/lib/jenkins/.ssh/id_rsa_sam'
  })
end

jenkins_plugins_ssh_config 'bitbucket.org' do
  options({
    'Port' => '22',
    'IdentityFile' => '/var/lib/jenkins/.ssh/id_rsa_sam'
  })
  action :update
end
