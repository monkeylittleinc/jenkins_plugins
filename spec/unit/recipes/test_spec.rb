require 'spec_helper'

describe 'jenkins_plugins::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6').converge(described_recipe)
  end

  it 'includes the `jenkins::java` recipe' do
    expect(chef_run).to include_recipe('jenkins::java')
  end

  it 'includes the `jenkins::master` recipe' do
    expect(chef_run).to include_recipe('jenkins::master')
  end
end
