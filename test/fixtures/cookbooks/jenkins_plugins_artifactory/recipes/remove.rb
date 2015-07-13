jenkins_plugins_artifactory 'artifactory' do
  url 'https://fake.com'
end

jenkins_plugins_artifactory 'artifactory' do
  action :remove
end
