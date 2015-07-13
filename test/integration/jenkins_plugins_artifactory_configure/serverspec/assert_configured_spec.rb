require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/org.jfrog.hudson.ArtifactoryBuilder.xml') do
  it { should exist }
  it { should be_file }
  it { should contain '<username>sam</username>' }
  it { should contain '<password>derp</password>' }
  it { should be_owned_by 'jenkins' }
  it { should be_mode '644' }
end

describe file('/var/lib/jenkins/jenkins.model.ArtifactManagerConfiguration.xml') do
  it { should exist }
  it { should be_file }
  it { should contain '<artifactManagerFactories/>' }
  it { should be_owned_by 'jenkins' }
  it { should be_mode '644' }
end
