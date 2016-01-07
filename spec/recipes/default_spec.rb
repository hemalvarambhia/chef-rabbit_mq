require 'chefspec'

describe "chef-rabbit_mq::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  
  it 'installs RabbitMQ server' do
    expect(chef_run).to install_package 'rabbitmq-server'
  end
 
  it 'starts the server' do
    expect(chef_run).to start_service 'rabbitmq-server'
  end
end