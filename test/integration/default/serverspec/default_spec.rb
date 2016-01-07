require 'spec_helper'

describe "installing RabbitMQ" do
  describe package('rabbitmq-server') do
    it { should be_installed }
  end

  describe service('rabbitmq-server') do
    it { should be_running }
  end
end