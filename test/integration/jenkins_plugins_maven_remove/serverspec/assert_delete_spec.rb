require_relative '../../../kitchen/data/spec_helper'

describe file('/var/lib/jenkins/hudson.tasks.Maven.xml') do
  it { should not_exist }
end
