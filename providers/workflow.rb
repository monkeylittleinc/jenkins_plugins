#
# Cookbook Name:: jenkins_plugins
# Provider:: workflow
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

action :create do
  converge_by("Create #{@new_resource}") do
    create_workflow_job
    service 'jenkins' do
      action :reload
    end
  end
end

action :delete do
  converge_by("Remove #{@new_resource}") do
    jenkins_job new_resource.name do
      action :delete
    end
  end
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
  end
end

def generate_file(xml)
  template xml do
    source 'workflow/job.xml.erb'
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
