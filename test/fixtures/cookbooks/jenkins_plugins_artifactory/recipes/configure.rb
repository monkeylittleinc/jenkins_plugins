jenkins_plugins_artifactory 'artifactory' do
  id '12345@67890'
  url 'https://fake.com'
end

jenkins_plugins_artifactory 'artifactory' do
  id '12345@67890'
  url 'https://fake.com'
  username 'sam'
  password 'derp'
  action :configure
end
