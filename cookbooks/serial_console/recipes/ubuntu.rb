mode = 'ubuntu'
config = node['serial_console'][mode]

template config['config'] do
  source mode
  action :create
end

grub_append mode do
  add_lines ([
    'serial --unit=0 --speed=115200',
    'console=tty0 console=ttyS0,115200'
  ])
  action :run
end
