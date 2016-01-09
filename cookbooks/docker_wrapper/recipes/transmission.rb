mount_path = '/nfs/torrent'

## service
service = 'transmission'
repo = 'randomcoww/transmission'
tag = 'latest'

## vpn container
service_vpn = 'transmission-vpn'
repo_vpn = 'randomcoww/openvpn_proxy'
tag_vpn = 'latest'

directory mount_path do
  recursive true
end

mount mount_path do
  device "#{node['docker_service']['nfs_server']}:/torrent"
  fstype "nfs"
  options "rw,#{node['docker_service']['nfs_mount_opts']}"
  action [:enable, :mount]
  notifies :redeploy, "docker_container[#{service_vpn}]", :delayed
  notifies :redeploy, "docker_container[#{service}]", :delayed
end

## vpn image
docker_image service_vpn do
  repo repo_vpn
  tag tag_vpn
  action :pull
  notifies :redeploy, "docker_container[#{service_vpn}]", :delayed
end

docker_container service_vpn do
  hostname "#{node.hostname}-#{service}"
  repo repo_vpn
  tag tag_vpn
  cap_add 'NET_ADMIN'
  devices [
    {
      "PathOnHost" => "/dev/net/tun",
      "PathInContainer" => "/dev/net/tun",
      "CgroupPermissions" => "rwm"
    }
  ]
  port ['9091:9091']
  binds [
    "#{mount_path}/openvpn/openvpn.conf:/openvpn/openvpn.conf",
    "#{mount_path}/openvpn/auth.conf:/openvpn/auth-user-pass.conf",
    "#{mount_path}/openvpn/ca.crt:/openvpn/ca.crt"
  ]
  restart_policy 'unless-stopped'
  action :run
  notifies :redeploy, "docker_container[#{service}]", :delayed
end

## create startup service and script
docker_wrapper_container_service service_vpn do
  container_name service_vpn
  action :enable
end

docker_image service do
  repo repo
  tag tag
  action :pull
  notifies :redeploy, "docker_container[#{service}]", :delayed
end

docker_container service do
  repo repo
  tag tag
  network_mode "container:#{service_vpn}"
  restart_policy 'on-failure'
  binds [
    "#{mount_path}/transmission:/var/lib/transmission-daemon"
  ]
  action :run
end
