require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/.ssh/id_rsa_sam') do
  it { should exist }
  it { should be_file }
  it do
    should contain <<-KEY
    Fake Key
    KEY
  end
  it { should be_mod '0600' }
  it { should be_owned_by 'jenkins' }
end
