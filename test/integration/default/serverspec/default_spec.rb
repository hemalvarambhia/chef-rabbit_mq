require 'spec_helper'

describe "installing RabbitMQ" do
  describe 'installing dependencies' do
    describe package('logrotate') do
      it { should be_installed }
    end
  end

  describe package('rabbitmq-server') do
    it { should be_installed }
  end

  describe service('rabbitmq-server') do
    it { should be_running }
  end
end