# jenkins_plugins Cookbook
[![Build Status](https://travis-ci.org/monkeylittleinc/jenkins_plugins.svg)](https://travis-ci.org/monkeylittleinc/jenkins_plugins)

This cookbook is designed to add an LWRPs around interacting with Jenkins Plugins.

## Requirements
- Chef 11 or higher
- **Ruby 1.9.3 or higher**

## Dependencies
- `jenkins`
- `maven`

## Resources
All examples show default values

### jenkins_plugins_workflow

```ruby
jenkins_plugins_workflow 'my-first-workflow-job' do
  script 'hello-world.groovy' # Required
  description '' # Optional
  sandbox false # Optional
  version '1.8' # Optional
  action :create
end
```

### jenkins_plugins_maven

```ruby
jenkins_plugins_maven 'M3'
	install false
end
```

### jenkins_plugins_git

```ruby
jenkins_plugins_git 'git' do
	install true
	install_system false
	global_name '
	global_email '
	create_account false
	home 'git'
	version ''
	system_version ''
	configure_ssh false
	ssh_host ''
	ssh_hostname ''
	ssh_port 22
	ssh_key ''
	ssh_strict_host_checking true
end
```

### jenkins_plugins_ssh

```ruby
jenkins_plugins_ssh 'name_for_key' do
	host '' # Required
	hostname '' # Optional
	port 22 # Optional
	key '' # Required
	type 'rss' # Optional - Can be ['rsa', 'dsa', 'ecdsa']
	strict_host_checking true # Optional
end
```

#### :add
This action will check for a key in the following format:

```ruby
#{jenkins_home}/.ssh/id_#{key_type}_#{name}
```

If this key does not exist the LWRP will add it and add your ssh configuration values also. 

If the ssh config file already exists it will append the new block to the end of the file.


#### :update
***TODO***


#### :remove
This action will check for a key in the following format:

```ruby
#{jenkins_home}/.ssh/id_#{key_type}_#{name}
```

If this key exists the LWRP will remove it.

***TODO***: Remove block from ssh config file

## Development
Please see the [Contributing](CONTRIBUTING.md) and [Issue Reporting](ISSUES.md) Guidelines.

## License & Authors
- Author: Sam Dunne [sam@sam-dunne.com](mailto:sam@sam-dunne.com)

```text
Copyright (C) 2015 Monkey Little

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

[travis]: http://travis-ci.org/monkeylittleinc/jenkins_plugins
