node['docker_container'].each { |container, opt|
  res = Chef::Resource::DockerCookbook::DockerContainer.new(container, run_context)
  opt.each { |k, v|
    res.send(k.to_sym, v) if res.respond_to?(k)
  }
}
