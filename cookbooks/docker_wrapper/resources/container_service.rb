actions :start, :enable, :disable, :stop
default_action :start

attribute :service, :kind_of => [String], :name_attribute => true
attribute :container_name, :kind_of => [String]
