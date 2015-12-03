def load_current_resource
  @current_resource = Chef::Resource::DockerWrapperContainerService.new(new_resource.service)
  @current_resource
end

def init_script
  return @init_script unless @init_script.nil?
  ## create startup service and script
  @init_script = template "container_service_#{new_resource.service}" do
    path ::File.join('/etc', 'init.d', new_resource.service)
    cookbook 'docker_wrapper'
    source 'init.erb'
    mode '0755'
    variables({
      :service_name => new_resource.service,
      :actions => {
        'start' => "docker start #{new_resource.container_name}",
        'stop' => "docker stop #{new_resource.container_name}",
        'restart' => "docker restart #{new_resource.container_name}",
        'attach' => "docker exec -it #{new_resource.container_name} /bin/bash",
      }
    })
    action :nothing
  end
  return @init_script
end

def init_service
  return @init_service unless @init_service.nil?
  @init_service = service new_resource.service do
    action :nothing
  end
  return @init_service
end

def action_start
  init_script.run_action(:create)
  init_service.run_action(:enable)
  init_service.run_action(:start)
end

def action_enable
  init_script.run_action(:create)
  init_service.run_action(:enable)
end

def action_stop
  init_service.run_action(:stop)
end

def action_disable
  init_service.run_action(:stop)
  init_service.run_action(:disable)
  init_script.run_action(:delete)
end
