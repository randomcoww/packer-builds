action :run
default_action :run

attribute :name, :kind_of => [String], :name_attribute => true
attribute :grub_config, :kind_of => [String], :default => '/etc/default/grub'
attribute :add_lines, :kind_of => [Array]
attribute :mkconfig_command, :kind_of => [Array], :default => 'grub-mkconfig -o /boot/grub/grub.cfg'
