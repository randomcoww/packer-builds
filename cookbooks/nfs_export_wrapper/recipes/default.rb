#
# Cookbook Name:: nfs_export_wrapper
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node['nfs_exports'].each { |path, opt|
  res = Chef::Resource::NfsExport.new(path, run_context)
  opt.each { |k, v|
    res.send(k.to_sym, v) if res.respond_to?(k)
  }
  res.run_action :create
} if node['nfs_exports']
