#
# Cookbook Name:: jenkins_plugins
# Provider:: git
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
  if @current_resource.exists
    Chef::Log.info 'Git already installed. Nothing to do.'
  else
    converge_by("Install #{@new_resource}") do
      install_system_git if new_resource.install_system
      install_git_plugin
      configure_git_tool
      configure_git_global_user
      service 'jenkins' do
        action :reload
      end
    end
  end
end

action :configure do
  converge_by("Configure #{@new_resource}") do
    remove_configuration
    service 'jenkins' do
      action :reload
    end
  end
end

action :remove do
  if @current_resource.exists
    converge_by("Remove #{@new_resource}") do
      remove_configuration
      service 'jenkins' do
        action :reload
      end
    end
  else
    Chef::Log.info 'Git not configured. Nothing to remove.'
  end
end

def load_current_resource
  @current_resource = Chef::Resource.resource_for_node(:jenkins_plugins_git, node).new(@new_resource.name)
  @current_resource.exists = git_configured? ? true : false
end

def git_configured?
  ::File.exist?("#{node['jenkins']['master']['home']}/hudson.plugins.git.GitTool.xml") && ::File.exist?("#{node['jenkins']['master']['home']}/hudson.plugins.git.GitSCM.xml")
end

def install_system_git
  package 'git'
end

def install_git_plugin
  jenkins_plugin 'git' do
    version new_resource.version
  end
end

def remove_configuration
  file "#{node['jenkins']['master']['home']}/hudson.plugins.git.GitTool.xml" do
    action :delete
  end

  file "#{node['jenkins']['master']['home']}/hudson.plugins.git.GitSCM.xml" do
    action :delete
  end
end

def configure_git_tool
  template "#{node['jenkins']['master']['home']}/hudson.plugins.git.GitTool.xml" do
    source 'git/git_tool.xml.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    variables(
      name: new_resource.name,
      home: new_resource.home,
      version: new_resource.client_version,
    )
    mode '0644'
  end
end

def configure_git_global_user
  template "#{node['jenkins']['master']['home']}/hudson.plugins.git.GitSCM.xml" do
    source 'git/git_scm.xml.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    variables(
      global_name: new_resource.global_name,
      global_email: new_resource.global_email,
      create_account: new_resource.create_account,
      version: new_resource.version,
    )
    mode '0644'
  end
end
