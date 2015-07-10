jenkins_plugins_git 'git' do
  home 'git'
  global_name 'Sam'
  global_email 'sam@fake.com'
end

jenkins_plugins_git 'git' do
  home 'git-clone'
  global_name 'Sam\'s Clone'
  global_email 'samclone@fake.com'
  action :configure
end
