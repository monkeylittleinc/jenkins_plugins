#
# Cookbook Name:: artifactory_pro
# Provider:: ssh
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

action :add do
  if @current_resource.exists
    Chef::Log.info 'SSH key exists. Nothing to do'
  else
    converge_by("Create #{@new_resource}") do
      create_or_append_config_file
      add_key
    end
  end
end

action :update do
  if @current_resource.exists
    converge_by("Update #{@new_resource}") do
      update_key
    end
  else
    Chef::Log.info 'SSH key doesn\'t exist. Nothing to update'
  end
end

action :remove do
  if @current_resource.exists
    converge_by("Remove #{@new_resource}") do
      remove_key
    end
  else
    Chef::Log.info 'SSH key doesn\'t exist. Nothing to remove'
  end
end

def load_current_resource
  @current_resource = Chef::Resource::JenkinsPluginsSsh.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.type(@new_resource.type)

  @current_resource.exists = does_key_exist? ? true : false
end

def does_key_exist?
  ::File.exist?("#{node['jenkins']['master']['home']}/.ssh/id_#{@new_resource.type}_#{@new_resource.name}")
end

def add_key
  file "#{node['jenkins']['master']['home']}/.ssh/id_#{@new_resource.type}_#{@new_resource.name}" do
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0600'
    action :create
  end
end

def update_key
  # TODO
end

def remove_key
  file "#{node['jenkins']['master']['home']}/.ssh/id_#{@new_resource.type}_#{@new_resource.name}" do
    action :delete
  end
end

def create_or_append_config_file
  directory "#{node['jenkins']['master']['home']}/.ssh" do
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0755'
    action :create
  end

  config_exists = ::File.exist?("#{node['jenkins']['master']['home']}/.ssh/config")
  config_exists ? append_config : create_config
end

def append_config
  contents = ::File.readline("#{node['jenkins']['master']['home']}/.ssh/config")
  template "#{node['jenkins']['master']['home']}/.ssh/config" do
    source 'ssh/ssh_config.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0644'
    variables(original_contents: contents,
              host: @new_resource.host,
              hostname: @new_resource.hostname,
              port: @new_resource.port,
              identity_file: "#{node['jenkins']['master']['home']}/.ssh/id_#{@new_resource.type}_#{@new_resource.name}",
              strict_host_key_checking: @new_resource.strict_host_checking)
  end
end

def create_config
  template "#{node['jenkins']['master']['home']}/.ssh/config" do
    source 'ssh/ssh_config.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0644'
    variables(host: new_resource.host,
              hostname: new_resource.hostname,
              port: new_resource.port,
              identity_file: "#{node['jenkins']['master']['home']}/.ssh/id_#{new_resource.type}_#{new_resource.name}",
              strict_host_key_checking: new_resource.strict_host_checking)
  end
end
