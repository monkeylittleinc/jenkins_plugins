#
# Cookbook Name:: jenkins_plugins
# Resource:: workflow
#

actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :description, kind_of: String, default: ''
attribute :sandbox, kind_of: [TrueClass, FalseClass], default: false
attribute :script, kind_of: String, required: true
attribute :version, kind_of: String, default: '1.8'
attribute :variables, kind_of: Hash, default: {}

attr_accessor :exists
