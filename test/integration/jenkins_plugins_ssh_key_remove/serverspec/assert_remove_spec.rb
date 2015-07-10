require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/.ssh/id_rsa_sam') do
  it { should not_exist }
end
