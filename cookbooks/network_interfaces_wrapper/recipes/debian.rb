node.save

node['network_interfaces'].each { |dev, opt|
  res = Chef::Resource::NetworkInterface::Debian.new(dev, run_context)
  opt.each { |k, v|
    res.send(k.to_sym, v) if res.respond_to?(k)
  }
  res.run_action :create
}
