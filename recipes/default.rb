#
# Cookbook Name:: chef-rabbit_mq
# Recipe:: default
#
# Copyright 2016, Software Craftsman of London
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default'

package 'rabbitmq-server' do
  action :install
end

template '/etc/rabbitmq/rabbitmq-env.conf' do
  action :create
end

service 'rabbitmq-server' do
  action :start
end

execute "create queue publisher" do
  command "rabbitmqctl add_user a_publisher publisher"
  action :run
end

execute "create queue publisher" do
  command "rabbitmqctl add_user a_consumer consumer"
  action :run
end

execute "set permissions for publisher" do
  command "rabbitmqctl set_permissions -p / a_publisher \"hello\" \".*\" \"^$\""
  action :run
end

execute "set permissions for consumer" do
  command "rabbitmqctl set_permissions -p / a_consumer \"hello\" \"^$\" \"hello\""
  action :run
end