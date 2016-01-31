Chef.resource :automaster_entry do
  property :mount_point, String, identity: true
  property :map, Path, identity: true
  property :master_config, Path do
    default { '/etc/auto.master' }
  end
  property :options, String

  recipe do
    file master_config

    replace_or_add mount_point do
      path master_config
      pattern "#{mount_point} #{map}.*"
      line "#{mount_point} #{map} #{options}"
      # notifies :reload, 'service[autofs]', :delayed
    end
  end
end

Chef.resource :map_entry do
  property :key, String, identity: true
  property :location, Path
  property :options, default: nil
  property :map, Path
  property :fstype, String
  property :mount_point, Path do
    default { '/' + map.match(/(?:\.)(.*)/).captures[0] }
  end
  recipe do
    file map
    automaster_entry mount_point, map do
    end
    service 'autofs'
    if options.nil?
      opts = fstype
    else
      opts = [fstype, options].join(',')
    end
    replace_or_add key do
      path map
      pattern "#{key}.*"
      line "#{key} -fstype=#{opts} #{location}"
      # notifies :reload, 'service[autofs]', :delayed
    end
  end
end
