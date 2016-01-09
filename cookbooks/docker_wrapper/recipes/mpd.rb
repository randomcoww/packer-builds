## service
service = 'mpd'
enable = true
mount_path = '/nfs/music'
repo = 'randomcoww/mpd'
tag = 'latest'

## storage container
service_store = 'mpd-store'
repo_store = 'phusion/baseimage'
tag_store = 'latest'

## nfs
directory mount_path do
  recursive true
end

mount mount_path do
  device "#{node['docker_service']['nfs_server']}:/music"
  fstype "nfs"
  options "ro,#{node['docker_service']['nfs_mount_opts']}"
  action [:enable, :mount]
  notifies :redeploy, "docker_container[#{service}]", :delayed
end

## storage container
docker_image service_store do
  repo repo_store
  tag tag_store
  action :pull_if_missing
end

docker_container service_store do
  hostname "#{node.hostname}-#{service_store}"
  repo repo_store
  tag tag_store
  volumes ["/var/lib/mpd/cache", "/var/lib/mpd/playlists"]
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
  restart_policy 'unless-stopped'
  volumes_from service_store
  binds ["#{mount_path}:/var/lib/mpd/music"]
  port ['8000:8000', '6600:6600']
  action :run
end
