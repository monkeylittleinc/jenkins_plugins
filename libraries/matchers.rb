if defined?(ChefSpec)
  def install_artifactory_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_artifactory, :install, resource_name)
  end

  def configure_artifactory_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_artifactory, :configure, resource_name)
  end

  def remove_artifactory_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_artifactory, :remove, resource_name)
  end

  def install_git_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_git, :install, resource_name)
  end

  def configure_git_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_git, :configure, resource_name)
  end

  def remove_git_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_git, :remove, resource_name)
  end

  def install_maven_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_maven, :install, resource_name)
  end

  def configure_maven_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_maven, :configure, resource_name)
  end

  def remove_maven_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_maven, :remove, resource_name)
  end

  def add_ssh_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_ssh_config, :add, resource_name)
  end

  def update_ssh_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_ssh_config, :update, resource_name)
  end

  def remove_ssh_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_ssh_config, :remove, resource_name)
  end

  def add_ssh_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_ssh_key, :add, resource_name)
  end

  def update_ssh_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_ssh_key, :update, resource_name)
  end

  def remove_ssh_key(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_ssh_key, :remove, resource_name)
  end

  def create_workflow_job(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_workflow, :create, resource_name)
  end

  def delete_workflow_job(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:jenkins_plugins_workflow, :delete, resource_name)
  end
end
