require 'chefspec'

describe "chef-rabbit_mq::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'updates the APT repos' do
    expect(chef_run).to include_recipe 'apt::default'
  end

  describe 'firewall rules' do
    it 'allows TCP connections through port 22' do
      expect(chef_run).to(
        create_firewall_rule('ssh').with(protocol: :tcp, port: 22))
    end

    it 'allows TCP connections through port 5672' do
      expect(chef_run).to(
        create_firewall_rule('rabbitmq').with(protocol: :tcp, port: 5672)
      )
    end
  end
  it 'installs RabbitMQ server' do
    expect(chef_run).to install_package 'rabbitmq-server'
  end
 
  it 'starts the server' do
    expect(chef_run).to start_service 'rabbitmq-server'
  end

  describe 'configuration' do
    it 'creates a configuration file' do
      expect(chef_run).to create_template('/etc/rabbitmq/rabbitmq-env.conf')
    end
  end
end
