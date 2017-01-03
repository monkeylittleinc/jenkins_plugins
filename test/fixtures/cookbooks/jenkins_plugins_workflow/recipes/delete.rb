jenkins_plugins_workflow 'workflow-job' do
  script 'hello-world.groovy.erb'
  variables(test_one: 'Hello',
            test: {
              two: 'World!'
            })
end

jenkins_plugins_workflow 'workflow-job' do
  action :delete
end
