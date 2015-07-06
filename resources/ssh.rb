#
# Cookbook Name:: jenkins_plugins
# Resource:: ssh
#

actions [:add, :remove]

default_action :add

attribute :host, kind_of: String
attribute :hostname, kind_of: String
attribute :port, kind_of: Integer
attribute :key, kind_of: String
attribute :type, equal_to: %w(dsa rsa ecdsa), default: 'rsa'
attribute :strict_host_checking, kind_of: [TrueClass, FalseClass], default: true

attr_accessor :exists
