require 'spec_helper'

describe "installing ruby" do
  describe package('rabbitmq-server') do
    it {
      should be_installed
    }
  end
end