#
# Cookbook Name:: network_interfaces_wrapper
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

## resource in modules breaks the run by incorrectly selecting to start module-init-tools rather than kmod.
## override module-init-tools with kmod.
include_recipe 'modules'
service 'module-init-tools' do
  service_name 'kmod'
  provider Chef::Provider::Service::Upstart
end

node['network_interfaces'].each { |dev, opt|
  res = Chef::Resource::NetworkInterface::Debian.new(dev, run_context)
  opt.each { |k, v|
    res.send(k.to_sym, v) if res.respond_to?(k)
  }
  res.run_action :create
}
