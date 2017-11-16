#
# Cookbook Name:: jenkins_plugins
# Provider:: artifactory
#
# Copyright (C) 2017 Monkey Little
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

use_inline_resources

def whyrun_supported?
  true
end

action :install do
  converge_by("Install #{@new_resource}") do
    install_artifactory_plugin
    configure_artifactory_plugin
    service 'jenkins' do
      action :reload
    end
  end
end

action :configure do
  converge_by("Configure #{@new_resource}") do
    configure_artifactory_plugin
  end
end

action :remove do
  if @current_resource.exists
    converge_by("Remove #{@new_resource}") do
      remove_artifactory_configuration
      service 'jenkins' do
        action :reload
      end
    end
  else
    Chef::Log.info 'Git not configured. Nothing to remove.'
  end
end

def load_current_resource
  @current_resource = Chef::Resource.resource_for_node(:jenkins_plugins_artifactory, node).new(@new_resource.name)
  @current_resource.exists = artifactory_configured? ? true : false
end

def artifactory_configured?
  ::File.exist?("#{node['jenkins']['master']['home']}/org.jfrog.hudson.ArtifactoryBuilder.xml") && ::File.exist?("#{node['jenkins']['master']['home']}/jenkins.model.ArtifactManagerConfiguration.xml")
end

def install_artifactory_plugin
  jenkins_plugin 'artifactory' do
    version new_resource.version
  end
end

def configure_artifactory_plugin
  template "#{node['jenkins']['master']['home']}/org.jfrog.hudson.ArtifactoryBuilder.xml" do
    source 'artifactory/builder.xml.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0644'
    sensitive true
    variables(version: new_resource.version,
              id: new_resource.id,
              url: new_resource.url,
              username: new_resource.username,
              password: new_resource.password,
              timeout: new_resource.timeout,
              bypass_proxy: new_resource.bypass_proxy)
  end

  cookbook_file "#{node['jenkins']['master']['home']}/jenkins.model.ArtifactManagerConfiguration.xml" do
    source 'artifactory/manager.xml'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0644'
    sensitive true
  end
end

def remove_artifactory_configuration
  file "#{node['jenkins']['master']['home']}/org.jfrog.hudson.ArtifactoryBuilder.xml" do
    action :delete
  end

  file "#{node['jenkins']['master']['home']}/jenkins.model.ArtifactManagerConfiguration.xml" do
    action :delete
  end

  jenkins_plugin 'artifactory' do
    action :uninstall
  end
end
