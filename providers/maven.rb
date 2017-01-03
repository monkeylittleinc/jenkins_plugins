#
# Cookbook Name:: jenkins_plugins
# Provider:: maven
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

use_inline_resources

def whyrun_supported?
  true
end

action :install do
  converge_by("Install #{@new_resource}") do
    install_and_configure
    service 'jenkins' do
      action :reload
    end
  end
end

action :configure do
  converge_by("Configure #{@new_resource}") do
    configure_maven
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
    Chef::Log.info 'Maven not configured. Nothing to rqemove.'
  end
end

def load_current_resource
  @current_resource = Chef::Resource::JenkinsPluginsMaven.new(@new_resource.name)
  @current_resource.exists = maven_configured? ? true : false
end

def maven_configured?
  ::File.exist?("#{node['jenkins']['master']['home']}/hudson.tasks.Maven.xml")
end

def install_and_configure
  recipe_eval do
    node.set['maven']['version'] = new_resource.version
    run_context.include_recipe 'maven'
  end
  configure_maven
end

def configure_maven
  template "#{node['jenkins']['master']['home']}/hudson.tasks.Maven.xml" do
    source 'maven/maven.xml.erb'
    cookbook 'jenkins_plugins'
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0644'
    variables(name: new_resource.name, home: new_resource.maven_home || node['maven']['m2_home'])
  end
end

def remove_configuration
  file "#{node['jenkins']['master']['home']}/hudson.tasks.Maven.xml" do
    action :delete
  end
end
