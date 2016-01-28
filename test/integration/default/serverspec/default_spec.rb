require 'spec_helper'

describe "installing RabbitMQ" do
  describe 'installing dependencies' do
    describe package('logrotate') do
      it { should be_installed }
    end
  end

  describe 'prerequisites' do
    describe port(22) do
      it { should be_listening.with('tcp')}
    end

    describe port(5672) do
      it { should be_listening}
    end
  end

  describe package('rabbitmq-server') do
    it { should be_installed }
  end

  describe service('rabbitmq-server') do
    it { should be_running }
  end

  describe 'configuration' do
    describe file('/etc/rabbitmq/rabbitmq-env.conf') do
      it { should exist }

      its(:content) do 
        should =~/NODENAME=rabbit@default-ubuntu-1404/ 
      end
    end
  end

  describe command "sudo rabbitmqctl list_users | grep guest" do
    its(:stdout) {
      should eq ""
    }
  end
end