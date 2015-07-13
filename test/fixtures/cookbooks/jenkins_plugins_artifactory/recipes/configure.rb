jenkins_plugins_artifactory 'artifactory' do
  url 'https://fake.com'
end

jenkins_plugins_artifactory 'artifactory' do
  url 'https://fake.com'
  username 'sam'
  password 'derp'
  action :configure
end
