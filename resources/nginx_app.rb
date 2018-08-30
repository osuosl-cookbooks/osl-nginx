resource_name :nginx_app

default_action :create

property :cert_file, [String, nil], default: nil
property :cert_key, [String, nil], default: nil
property :cookbook, String, default: 'osl-nginx'
property :cookbook_include, [String, nil], default: nil
property :custom_logs, [true, false], default: false
property :server_port, [String, Integer], default: 80
property :directory, String, default: lazy { "/var/www/#{name}" }
property :directive_http, [Array, nil], default: nil
property :directive_https, [Array, nil], default: nil
property :directory_index, [String, nil], default: nil
property :enable, [true, false], default: true
property :include_config, [true, false], default: false
property :include_name, String, default: lazy { name }
property :include_resource, String, default: 'cookbook_file'
property :local, [true, false], default: false
property :server_aliases, Array, default: []
property :ssl_enable, [true, false], default: false
property :template, String, default: 'nginx_app.conf.erb'

action :create do
  include_recipe 'osl-nginx::default'

  declare_resource(:directory,"#{node['nginx']['log_dir']}/#{name}/access") do
    owner 'root'
    group 'root'
    mode 0644
    recursive true
  end

  declare_resource(:directory, "#{node['nginx']['log_dir']}/#{name}/error") do
    owner 'root'
    group 'root'
    mode 0644
  end

  if include_config
    vhost_include = ::File.join(node['nginx']['dir'], 'sites-available', "#{include_name}_include.conf")

    case include_resource
    when 'cookbook_file'
      cookbook_file vhost_include do
        source "#{node['osl-nginx']['hostname']}/#{include_name}.conf"
        cookbook cookbook_include unless cookbook_include.nil?
        owner node['nginx']['user']
        group node['nginx']['group']
        mode 0644

        if ::File.exist?(::File.join(node['nginx']['dir'], 'sites-enabled', "#{include_name}.conf"))
          notifies :reload, 'service[nginx]'
        end
      end

    when 'template'
      declare_resource(:template, vhost_include) do
        source "#{include_name}.conf.erb"
        cookbook cookbook_include unless cookbook_include.nil?
        owner node['nginx']['user']
        group node['nginx']['group']
        mode 0644

        if ::File.exist?(::File.join(node['nginx']['dir'], 'sites-enabled', "#{include_name}.conf"))
          notifies :reload, 'service[nginx]'
        end
      end
    else
      Chef::Log.warn "Unable to create include resource for type #{include_resource}"
    end
  end

  declare_resource(:template, "#{node['nginx']['dir']}/sites-available/#{name}.conf") do
    source template
    cookbook new_resource.cookbook
    owner node['nginx']['user']
    group node['nginx']['group']
    mode 0644
    variables(
      server_aliases: server_aliases,
      params: all_params
    )

    if ::File.exist?(::File.join(node['nginx']['dir'], 'sites-enabled', "#{name}.conf"))
      notifies :reload, 'service[nginx]'
    end
  end

  nginx_site "#{name}.conf" do
    if new_resource.enable
      action :enable
    else
      action :disable
    end
  end
end

def all_params
  this = self
  self.class.properties(true).keys.each_with_object({}) do |prop, acc|
    acc[prop] = this.send(prop)
  end
end
