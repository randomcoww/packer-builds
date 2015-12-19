service = 'ssh_gateway'
repo = 'randomcoww/ssh_gateway'
tag = 'latest'

docker_image service do
  repo repo
  tag tag
  action :pull
  notifies :redeploy, "docker_container[#{service}]"
end

docker_container service do
  hostname "#{node.hostname}-#{service}"
  repo repo
  tag tag
  restart_policy 'on-failure'
  env [
    'SSH_USER=madcoww',
    'SSH_GROUP=madcoww',
    'SSH_HOME=/home/madcoww',
    'GIT_REPO=https://github.com/randomcoww/ssh-gateway_user_config.git',
    'GIT_BRANCH=master',
  ]
  port ['2222:22']
  action :run
end

## create startup service and script
docker_wrapper_container_service service do
  container_name service
  action :enable
end
