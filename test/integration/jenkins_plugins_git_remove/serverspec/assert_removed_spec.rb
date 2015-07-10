require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins//hudson.plugins.git.GitTool.xml') do
  it { should not_exist }
end

describe file('/var/lib/jenkins//hudson.plugins.git.GitSCM.xml') do
  it { should not_exist }
end
