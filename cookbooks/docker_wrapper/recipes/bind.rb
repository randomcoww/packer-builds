service = 'bind'
enable = true
repo = 'randomcoww/bind'
tag = 'latest'

di = docker_image service do
  repo repo
  tag tag
  #action :pull
  #notifies :redeploy, "docker_container[#{service}]"  
end

docker_container service do
  #hostname "#{node.hostname}-#{service}"
  network_mode 'host'
  repo repo
  tag tag
  restart_policy 'unless-stopped'
  #dns ['127.0.0.1']
  env [
    'GIT_REPO=https://github.com/randomcoww/bind-static_zones.git',
    'GIT_BRANCH=master'
  ]
  #port ['53:53/udp']
  action :run
end

di.run_action(:pull_if_missing)

unless di.updated_by_last_action?
  di.notifies(:redeploy, "docker_container[#{service}]")
  di.run_action(:pull)
end
