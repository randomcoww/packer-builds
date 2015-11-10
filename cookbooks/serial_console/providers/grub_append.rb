require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

def load_current_resource
  @current_resource = Chef::Resource::GrubAppend.new(new_resource.name)
  @current_resource
end

def file_editor
  @file_editor ||= Chef::Util::FileEdit.new(new_resource.grub_config)
end

def add_lines
  new_resource.add_lines.each { |e|
    file_editor.insert_line_if_no_match("/^#{e}$/", e)
  }
  file_editor.write_file
end

def delete_lines
end

def modify_lines
end

def make_grub_conf
  shell_out!(new_resource.mkconfg_command)
end

def action_run
  delete_lines
  modify_lines
  add_lines
  make_grub_conf if file_editor.file_edited?
end
