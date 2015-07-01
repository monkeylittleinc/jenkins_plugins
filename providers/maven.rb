#
# Cookbook Name:: jenkins_plugins
# Provider:: maven
#

action :configure do
  recipe_eval { run_context.include_recipe 'maven' } if new_resource.install
  write_maven_configuration
  jenkins_command 'restart'

  new_resource.updated_by_last_action(true)
end

def write_maven_configuration
  template "#{node['jenkins']['master']['home']}/hudson.tasks.Maven.xml" do
    source 'maven.xml.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0644'
    variables(name: new_resource.name)
  end
end
