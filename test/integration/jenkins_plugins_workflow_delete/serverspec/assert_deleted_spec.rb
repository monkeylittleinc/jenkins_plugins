require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/jobs/workflow-job/config.xml') do
  it { should not_exist }
end
