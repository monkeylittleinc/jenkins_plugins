require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/jobs/workflow-job/config.xml') do
  it { should exist }
  it { should be_file }
  it { should contain '\'Hello, World!\'' }
  it { should be_owned_by 'jenkins' }
end
