require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/.ssh/config') do
  it { should exist }
  it { should be_file }
  it { should_not contain 'Host bitbucket.org' }
  it { should be_owned_by 'jenkins' }
end
