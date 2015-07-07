#
# Cookbook Name:: jenkins_plugins
# Recipe:: test
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

include_recipe 'jenkins::java'
include_recipe 'jenkins::master'

jenkins_plugins_workflow 'workflow-job' do
  script 'workflow/hello-world.groovy'
end

jenkins_plugins_maven 'M3' do
  install true
end

jenkins_plugins_ssh 'sam' do
  host 'bitbucket.org'
  hostname 'altssh.bitbucket.org'
  port 443
  type 'rsa'
  key '-----BEGIN RSA PRIVATE KEY----- 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 -----END RSA PRIVATE KEY----- '
  strict_host_checking false
  action :add
end
