require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins//hudson.plugins.git.GitTool.xml') do
  it { should exist }
  it { should be_file }
  it { should contain '<name>git-clone</name>' }
  it { should contain '<name>git</name>' }
  it { should be_owned_by 'jenkins' }
  it { should be_mode '0644' }
end

describe file('/var/lib/jenkins//hudson.plugins.git.GitSCM.xml') do
  it { should exist }
  it { should be_file }
  it { should contain '<globalConfigName>Sam\'s Clone</globalConfigName>' }
  it { should not_contain '<globalConfigName>Sam</globalConfigName>' }
  it { should be_owned_by 'jenkins' }
  it { should be_mode '0644' }
end

describe package('git') do
  it { should be_installed }
end
