require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/hudson.tasks.Maven.xml') do
  it { should exist }
  it { should be_file }
  it { should contain '<home>/usr/local/maven_fake_home</home>' }
  it { should be_owned_by 'jenkins' }
end

describe package('maven') do
  it { should be_installed }
end
