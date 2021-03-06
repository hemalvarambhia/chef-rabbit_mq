#
# Cookbook Name:: chef-rabbit_mq
# Recipe:: default
#
# Copyright 2016, Software Craftsman of London
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default'
Chef::Resource::Execute.send(:include, ChefRabbitMQ::BrokerHelper)

firewall 'default' do
  action :install
end

firewall_rule 'ssh' do
  port 22
  protocol :tcp
  command :allow
end

firewall_rule 'rabbitmq' do
  port 5672
  protocol :tcp
  command :allow
end

package 'rabbitmq-server' do
  action :install
end

template '/etc/rabbitmq/rabbitmq-env.conf' do
  action :create
end

service 'rabbitmq-server' do
  action :start
end

node[:rabbitmq][:accounts].each do |account|
  execute "create user #{account[:username]}" do
    command "rabbitmqctl add_user #{account[:username]} #{account[:password]}"
    not_if { user_exists? account[:username] }
    action :run
  end

  execute "set user #{account[:username]} permissions" do
    command "rabbitmqctl set_permissions -p / #{account[:username]} \".*\" \".*\" \".*\""
    action :run
  end
end

execute "delete 'guest' user" do
  command "rabbitmqctl delete_user guest"
  only_if { user_exists? "guest" }
  action :run
end

