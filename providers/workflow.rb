#
# Cookbook Name:: jenkins_plugins
# Provider:: workflow
#

action :create do
  create_workflow_job
end

def create_workflow_job
  xml = ::File.join(Chef::Config[:file_cache_path], "#{new_resource.name}.xml")
  install_plugin
  generate_file(xml)
  create_job(xml)
end

def install_plugin
  jenkins_plugin 'workflow-aggregator' do
    action :install
    version new_resource.version
    install_deps true
    notifies :restart, 'service[jenkins]', :immediately
  end
end

def generate_file(xml)
  template xml do
    source 'job.xml.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    variables(description: new_resource.description,
              script: new_resource.script,
              sandbox: new_resource.sandbox,
              version: new_resource.version,
              variables: new_resource.variables)
  end
end

def create_job(xml)
  jenkins_job new_resource.name do
    config xml
  end
end
