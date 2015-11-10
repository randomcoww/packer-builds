## resource in modules breaks the run by incorrectly selecting to start module-init-tools rather than kmod.
## override module-init-tools with kmod.
include_recipe 'modules'
service 'module-init-tools' do
  service_name 'kmod'
  provider Chef::Provider::Service::Upstart
end

include_recipe 'network_interfaces_wrapper::default'
