mode = 'ubuntu'
config = node['serial_console'][mode]

template config['config'] do
  source "#{mode}.rb"
  action :create
end

serial_console_grub_append mode do
  add_lines ([
    'GRUB_SERIAL_COMMAND="serial --unit=0 --speed=115200"',
    'GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200"'
  ])
  action :run
end
