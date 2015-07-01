# jenkins_plugins Cookbook
This cookbook is designed to add an LWRPs around interacting with Jenkins Plugins.

## Requirements
### dependencies
- `jenkins`
- `maven`

## Usage
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
```
