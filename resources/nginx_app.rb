resource_name :nginx_app
provides :nginx_app

default_action :create

property :cert_file, [String, nil]
property :cert_key, [String, nil]
property :cookbook, String, default: 'osl-nginx'
property :cookbook_include, [String, nil]
property :custom_logs, [true, false], default: false
property :server_port, [String, Integer], default: 80
property :directory, String, default: lazy { "/var/www/#{name}" }
property :directive_http, [Array, nil]
property :directive_https, [Array, nil]
property :directory_index, [String, nil]
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

  declare_resource(:directory, "#{nginx_log_dir}/#{new_resource.name}/access") do
    owner 'root'
    group 'root'
    mode '0644'
    recursive true
  end

  declare_resource(:directory, "#{nginx_log_dir}/#{new_resource.name}/error") do
    owner 'root'
    group 'root'
    mode '0644'
  end

  if new_resource.include_config
    vhost_include = ::File.join(nginx_dir, 'includes.d', "#{new_resource.include_name}_include.conf")

    case new_resource.include_resource
    when 'cookbook_file'
      cookbook_file vhost_include do
        source "#{node['osl-nginx']['hostname']}/#{new_resource.include_name}.conf"
        cookbook new_resource.cookbook_include unless new_resource.cookbook_include.nil?
        owner nginx_user
        group nginx_user
        mode '0644'

        if ::File.exist?(::File.join(nginx_dir, 'includes.d', "#{new_resource.include_name}.conf"))
          notifies :reload, 'nginx_service[osuosl]'
        end
      end

    when 'template'
      declare_resource(:template, vhost_include) do
        source "#{new_resource.include_name}.conf.erb"
        cookbook new_resource.cookbook_include unless new_resource.cookbook_include.nil?
        owner nginx_user
        group nginx_user
        mode '0644'

        if ::File.exist?(::File.join(nginx_dir, 'includes.d', "#{new_resource.include_name}.conf"))
          notifies :reload, 'nginx_service[osuosl]'
        end
      end
    else
      Chef::Log.warn "Unable to create include resource for type #{new_resource.include_resource}"
    end
  end

  nginx_site new_resource.name do
    cookbook new_resource.cookbook
    template new_resource.template
    variables(
      server_aliases: new_resource.server_aliases,
      nginx_log_dir: nginx_log_dir,
      nginx_dir: nginx_dir,
      params: all_params
    )
  end
end

def all_params
  this = self
  self.class.properties(true).keys.each_with_object({}) do |prop, acc|
    acc[prop] = this.send(prop)
  end
end
