#
# Cookbook Name:: osl-nginx
# definition:: nginx_app
#
# Copyright (C) 2014 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
define :nginx_app,
       template: 'nginx_app.conf.erb',
       include_resource: 'cookbook_file',
       local: false,
       enable: true do
  include_recipe 'osl-nginx::default'

  cookbook = params[:cookbook] || 'osl-nginx'
  include_name = params[:include_name] || params[:name]

  directory "#{node['nginx']['log_dir']}/#{params[:name]}/access" do
    owner 'root'
    group 'root'
    mode 0644
    recursive true
    action :create
  end
  directory "#{node['nginx']['log_dir']}/#{params[:name]}/error" do
    owner 'root'
    group 'root'
    mode 0644
    action :create
  end
  if params[:include_config]
    vhost_include = ::File.join(
      node['nginx']['dir'],
      'sites-available',
      "#{include_name}_include.conf"
    )
    case params[:include_resource]
    when 'cookbook_file'
      cookbook_file vhost_include do
        source "#{node['osl-nginx']['hostname']}/#{include_name}.conf"
        cookbook params[:cookbook_include] if params[:cookbook_include]
        owner node['nginx']['user']
        group node['nginx']['group']
        mode 0644
        if ::File.exist?(::File.join(
                           node['nginx']['dir'],
                           'sites-enabled',
                           "#{include_name}.conf"
        ))
          notifies :reload, 'service[nginx]'
        end
      end
    when 'template'
      template vhost_include do
        source "#{include_name}.conf.erb"
        cookbook params[:cookbook_include] if params[:cookbook_include]
        owner node['nginx']['user']
        group node['nginx']['group']
        mode 0644
        if ::File.exist?(::File.join(
                           node['nginx']['dir'],
                           'sites-enabled',
                           "#{include_name}.conf"
        ))
          notifies :reload, 'service[nginx]'
        end
      end
    else
      Chef::Log.warn 'Unable to create include resource for type ' +
                     params[:include_resource]
    end
  end
  template "#{node['nginx']['dir']}/sites-available/#{params[:name]}.conf" do
    source params[:template] || 'nginx_app.conf.erb'
    cookbook cookbook
    owner node['nginx']['user']
    group node['nginx']['group']
    mode 0644
    variables(
      server_aliases: params[:server_aliases] || [],
      params: params
    )
    if ::File.exist?(::File.join(
                       node['nginx']['dir'],
                       'sites-enabled',
                       "#{params[:name]}.conf"
    ))
      notifies :reload, 'service[nginx]'
    end
  end
  nginx_site "#{params[:name]}.conf" do
    if params[:enable]
      action :enable
    else
      action :disable
    end
  end
end
