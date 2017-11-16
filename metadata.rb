name             'jenkins_plugins'
maintainer       'Monkey Little'
maintainer_email 'cookbooks@monkeylittle.com'
license          'MIT'
description      'Installs/Configures jenkins_plugins'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.5.0'

depends 'jenkins'
depends 'maven', '4.0.1'
depends 'ssh', '0.10.22'

issues_url 'https://github.com/monkeylittleinc/jenkins_plugins/issues'
source_url 'https://github.com/monkeylittleinc/jenkins_plugins'

supports 'centos'
supports 'redhat'

chef_version '>= 12'
