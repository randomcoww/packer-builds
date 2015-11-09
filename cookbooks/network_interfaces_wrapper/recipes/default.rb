#
# Cookbook Name:: network_interfaces_wrapper
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default['network_interfaces'].each { |dev, opt|
  res = Chef::Resource::NetworkInterface.new(dev, run_context)
  opt.each { |k, v|
    res.send("#{k}=".to_sym, v) if res.respond_to?(k)
  }
  res.run_action('create')
}
