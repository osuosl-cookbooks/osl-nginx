#
# Cookbook Name:: osl-nginx
# Recipe:: vhosts 
#
# Copyright (C) 2013 Oregon State University
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
include_recipe "osl-nginx::default"

node['osl-nginx']['hostsites']['vhosts'].each do |key, site|
   web_root = site.fetch("directory", "#{node['osl-nginx']['hostsites']['default_root']}/#{key}") 
    directory web_root do 
        owner "root"
        group "root"
        mode 00644
        recursive true
        action :create
    end
    directory "#{node['nginx']['log_dir']}/#{key}/access" do 
        owner "root"
        group "root"
        mode 00644
        recursive true
        action :create
    end
    directory "#{node['nginx']['log_dir']}/#{key}/error" do 
        owner "root"
        group "root"
        mode 00644
        action :create
    end
    if site.has_key?("custom_config") then
        vhost_include = "#{node['nginx']['dir']}/sites-available/#{key}_include.conf"
        cookbook_file vhost_include do
            source "#{node['osl-nginx']['hostname']}/#{key}.conf" 
            owner "root"
            group "root"
            mode 0644
            if ::File.exists?("#{node['nginx']['dir']}/sites-enabled/#{key}.conf")
                notifies :reload, "service[nginx]"
            end
        end
    end
    template "#{node['nginx']['dir']}/sites-available/#{key}.conf" do
        source "nginx_app.conf.erb"
        owner "root"
        group "root"
        mode 0644
        variables({ 
            :server_name => key,
            :server_aliases => site.fetch("aliases", []),
            :directory => web_root,
            :custom_config => vhost_include,
            :custom_logs => site.has_key?("custom_logs")
        })
        if ::File.exists?("#{node['nginx']['dir']}/sites-enabled/#{key}.conf")
            notifies :reload, "service[nginx]"
        end
    end 
    nginx_site "#{key}.conf" do
        if site.has_key?("disable") then
            enable false
        else 
            enable true
        end
    end
end 
