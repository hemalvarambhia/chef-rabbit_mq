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

user = "a_publisher"
password = "publisher"
execute "create user #{user}" do
  command "rabbitmqctl add_user #{user} #{password}"
  not_if { user_exists? user }
  action :run
end

execute "set permissions for #{user}" do
  command "rabbitmqctl set_permissions -p / #{user} \"^hello$\" \".*\" \"^$\""
  action :run
end

user = "a_consumer"
password = "consumer"
execute "create user #{user}" do
  command "rabbitmqctl add_user #{user} #{password}"
  not_if { user_exists? user }
  action :run
end

execute "set permissions for consumer" do
  command "rabbitmqctl set_permissions -p / #{user} \"^hello$\" \"^$\" \"hello\""
  action :run
end
