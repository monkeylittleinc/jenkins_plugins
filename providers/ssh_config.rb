#
# Cookbook Name:: jenkins_plugins
# Provider:: ssh_config
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

action :add do
  converge_by("Add #{@new_resource}") do
    add_config_value
  end
end

action :update do
  converge_by("Update #{@new_resource}") do
    remove_config_value
    add_config_value
  end
end

action :remove do
  converge_by("Remove #{@new_resource}") do
    remove_config_value
  end
end

def add_config_value
  ssh_config new_resource.name do
    options new_resource.options
    user node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    path "#{node['jenkins']['master']['home']}/.ssh/config"
  end
end

def remove_config_value
  ssh_config new_resource.name do
    action :remove
  end
end
