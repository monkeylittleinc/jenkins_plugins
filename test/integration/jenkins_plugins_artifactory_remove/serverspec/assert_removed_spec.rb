require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/org.jfrog.hudson.ArtifactoryBuilder.xml') do
  it { should_not exist }
end

describe file('/var/lib/jenkins/jenkins.model.ArtifactManagerConfiguration.xml') do
  it { should_not exist }
end
