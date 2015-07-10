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
  script 'workflow/hello-world.groovy.erb'
  variables ({
    test_one: "Hello",
    test: {
      two: "World!"
    }
  })
end

jenkins_plugins_maven 'M3' do
  action :install
end

jenkins_plugins_ssh_key 'sam' do
  type 'rsa'
  key <<-KEY
  -----BEGIN RSA PRIVATE KEY-----
  MIIJKQIBAAKCAgEAv39xGNZys5hEU6UBvunu8nFDBrNgOmi8jmGnsZ+LPtjoekf/
  rXkWfEZe2BZCEd4GAK3OqCXJasM1fri9IG+6E9PscJZLy49PuwDAiDebKYHOEOBt
  /nvgiBvXddr9EGI/cu7ydiOEFQQwxSz+4gGQdrqBhF6t7sxswbzyNi9w9Lgi5lfd
  kBy/GV1qXlZw4JtbwF1xE5HsFc7gM54hdiZQ5ojxdA6Ylb6cUPQc9vgsVHR9DYHw
  xN+TFRe/WlABmUq5DyKzCHvK7OiUwyt1wdO2pqO6cLSIlhdB73EHOuwFg2P0foI2
  Lq0RUv8o9j9irNTawiDMa/uYUMTy6ZHjrqoMKNwfjCGbX6BOLDC5dOMBz5/haYYR
  -----END RSA PRIVATE KEY-----
  KEY
  action :add
end

jenkins_plugins_ssh_config 'bitbucket.org' do
  options({
    'Hostname' => 'altssh.bitbucket.org',
    'Port' => '443',
    'IdentityFile' => '/var/lib/jenkins/.ssh/id_rsa_sam'
  })
end
