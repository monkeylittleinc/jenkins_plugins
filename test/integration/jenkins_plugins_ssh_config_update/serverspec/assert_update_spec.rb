require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/.ssh/config') do
  it { should exist }
  it { should be_file }
  it { should contain 'Port 22' }
  it { should_not contain 'Port 443' }
  it { should be_owned_by 'jenkins' }
end
