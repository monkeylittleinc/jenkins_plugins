if defined?(ChefSpec)
  def maven_configure(tool_name)
    ChefSpec::Matchers::ResourceMatcher.new(jenkins_plugins_maven, :configure, tool_name)
  end

  def workflow_create(job_name)
    ChefSpec::Matchers::ResourceMatcher.new(jenkins_plugins_workflow, :create, job_name)
  end
end
