# jenkins_plugins Cookbook
[![Build Status](https://travis-ci.org/monkeylittleinc/jenkins_plugins.svg)](https://travis-ci.org/monkeylittleinc/jenkins_plugins) [![Cookbook Version](https://img.shields.io/cookbook/v/jenkins_plugins.svg)](https://supermarket.chef.io/cookbooks/jenkins_plugins) [![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/monkeylittleinc/jenkins_plugins)

This cookbook is designed to add an LWRPs around interacting with Jenkins Plugins.

## Requirements
- Chef 11 or higher
- **Ruby 1.9.3 or higher**

## Dependencies
- `jenkins`
- `maven`
- `ssh`

## Plugins Available
1. [Workflow](#jenkins_plugins_workflow)
2. [Maven](#jenkins_plugins_maven)
3. [Git](#jenkins_plugins_git)
4. [Artifactory](#jenkins_plugins_artifactory)
5. [SSH Keys](#jenkins_plugins_ssh_key)
6. [SSH Config](#jenkins_plugins_ssh_config)

--------------------------------------------------------------------------------

## Resources
### jenkins_plugins_workflow
> The Workflow plugin suite attempts to make it possible to directly write that script, what people often call a workflow (sometimes abbreviated flow), while integrating with Jenkins features like slaves and publishers.

- [Workflow Plugin Home](https://wiki.jenkins-ci.org/display/JENKINS/Workflow+Plugin)

```ruby
jenkins_plugins_workflow 'my-first-workflow-job' do
  script 'hello-world.groovy' # Required
  description '' # Optional
  sandbox false # Optional
  version '1.8' # Optional
  action :create
end
```

--------------------------------------------------------------------------------

### jenkins_plugins_maven
- [Maven Plugin Home]()

```ruby
jenkins_plugins_maven 'M3'
  install false
end
```

--------------------------------------------------------------------------------

### jenkins_plugins_git
- [Git Plugin Home](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)

```ruby
jenkins_plugins_git 'git' do
  install true
  install_system false
  global_name ''
  global_email ''
  create_account false
  home 'git'
  version ''
  client_version ''
end
```

--------------------------------------------------------------------------------

### jenkins_plugins_artifactory
- [Artifactory Plugin Home](https://wiki.jenkins-ci.org/display/JENKINS/Artifactory+Plugin)

```ruby
jenkins_plugins_artifactory 'artifactory' do
  url '' # Required
  username ''
  password ''
  timeout 300
  bypass_proxy false
end
```

--------------------------------------------------------------------------------

### jenkins_plugins_ssh_key
This LWRP is slightly out of key with everything else. It is not configuring anything Jenkins specific, it is simply used to write a private ssh key. This is here to enable the git LWRP to work correctly when needing to authenticate against a repository.

```ruby
jenkins_plugins_ssh 'name' do
  type 'rsa' # Optional - Can be ['rsa', 'dsa', 'ecdsa']
end
```

#### :add
This action will check for a key in the following format:

```ruby
#{jenkins_home}/.ssh/id_#{key_type}_#{name}
```

If this key does not exist the LWRP will add it.

#### :update
This action will update the contents of the key file if they have changed.

#### :remove
This action will check for a key in the following format:

```ruby
#{jenkins_home}/.ssh/id_#{key_type}_#{name}
```

If this key exists the LWRP will remove it.

### jenkins_plugins_ssh_config
#### TODO
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
