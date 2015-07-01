#
# Cookbook Name:: jenkins_plugins
# Resource:: maven
#

actions :configure

default_action :configure

attribute :install, kind_of: [TrueClass, FalseClass], default: false
