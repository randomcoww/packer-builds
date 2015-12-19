## service
service = 'unifi'
enable = true
repo = 'randomcoww/unifi'
tag = 'latest'

## storage container
service_store = 'unifi-store'
repo_store = 'phusion/baseimage'
tag_store = 'latest' 

##
docker_image service_store do
  repo repo_store
  tag tag_store
  action :pull_if_missing
end
 
docker_container service_store do
  hostname "#{node.hostname}-#{service_store}"
  repo repo_store
  tag tag_store
  volumes "/var/lib/unifi"
  action :create
  notifies :redeploy, "docker_container[#{service}]", :delayed
end

docker_image service do
  repo repo
  tag tag
  action :pull
  notifies :redeploy, "docker_container[#{service}]", :delayed
end

docker_container service do
  hostname "#{node.hostname}-#{service}"
  repo repo
  tag tag
  restart_policy 'on-failure'
  volumes_from service_store
  port ['8080:8080', '8443:8443']
  action :run
end

## create startup service and script
docker_wrapper_container_service service do
  container_name service
  action :enable
end
