service = 'bind'
enable = true
repo = 'randomcoww/bind'
tag = 'latest'

docker_image service do
  repo repo
  tag tag
  action :pull
  notifies :redeploy, "docker_container[#{service}]"  
end

docker_container service do
  #hostname "#{node.hostname}-#{service}"
  network_mode 'host'
  repo repo
  tag tag
  restart_policy 'on-failure'
  #dns ['127.0.0.1']
  env [
    'GIT_REPO=https://github.com/randomcoww/bind-static_zones.git',
    'GIT_BRANCH=master'
  ]
  #port ['53:53/udp']
  action :run
end

## create startup service and script
docker_wrapper_container_service service do
  container_name service
  action :enable
end
