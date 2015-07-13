#
# Cookbook Name:: jenkins_plugins
# Provider:: artifactory
#
# Copyright (C) 2015 Monkey Little
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

def whyrun_supported?
  true
end

action :install do
  converge_by("Install #{@new_resource}") do
    install_artifactory_plugin
    configure_artifactory_plugin
    jenkins_command 'restart'
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
      jenkins_command 'restart'
    end
  else
    Chef::Log.info 'Git not configured. Nothing to remove.'
  end
end

def load_current_resource
  @current_resource = Chef::Resource::JenkinsPluginsArtifactory.new(@new_resource.name)
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
              id: generate_id,
              url: new_resource.url,
              username: new_resource.username,
              password: new_resource.password,
              timeout: new_resource.timeout,
              bypass_proxy: new_resource.bypass_proxy)
  end

  file "#{node['jenkins']['master']['home']}/jenkins.model.ArtifactManagerConfiguration.xml" do
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

# This nonsense reflects this: https://github.com/jenkinsci/artifactory-plugin/blob/master/src/main/java/org/jfrog/hudson/ArtifactoryServer.java#L89
def generate_id
  size = new_resource.url.size
  hash = 0
  new_resource.url.chars.each_with_index do |ch, i|
    hash += ch.ord * (31**(size - (i + 1)))
  end
  hash + '@' + DateTime.now.strftime('%Q')
end
