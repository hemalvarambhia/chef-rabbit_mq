#
# Cookbook Name:: chef-rabbit_mq
# Recipe:: default
#
# Copyright 2016, Software Craftsman of London
#
# All rights reserved - Do Not Redistribute
#

package 'rabbitmq-server' do
  action :install
end

service 'rabbitmq-server' do
  action :start
end