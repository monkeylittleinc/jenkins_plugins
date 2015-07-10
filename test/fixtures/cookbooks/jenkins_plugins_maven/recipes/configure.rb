jenkins_plugins_maven 'M3' do
  action :install
end

jenkins_plugins_maven 'M3' do
  maven_home '/usr/local/maven_fake_home'
  action :configure
end
