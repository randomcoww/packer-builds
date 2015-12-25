#docker_service 'default' do
#  icc false
#  action [:create]
#end

node['docker_service'].each_pair { |k, v|
  res = docker_service 'docker' do
    action :nothing
  end
  res.send(k.to_sym, v) if res.respond_to?(k)
  res.run_action :create
}
