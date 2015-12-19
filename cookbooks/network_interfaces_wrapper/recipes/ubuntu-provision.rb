#
# Cookbook Name:: network_interfaces_wrapper
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'modules'
service 'modules-load' do
  ignore_failure true
  action :nothing
end

service 'module-init-tools' do
  ignore_failure true
  action :nothing
end

service 'kmod' do
  ignore_failure true
  action :nothing
end

node['network_interfaces'].each { |dev, opt|
  res = Chef::Resource::NetworkInterface::Debian.new(dev, run_context)
  opt.each { |k, v|
    res.send(k.to_sym, v) if res.respond_to?(k)
  }
  res.run_action :create
}
