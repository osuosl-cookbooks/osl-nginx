#
# Cookbook Name:: osl-nginx
# lwrp:: nginx_app
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

define :nginx_app, :template => "nginx_app.conf.erb", :local => false, :enable => true do

    include_recipe "osl-nginx::default"
    
    directory "#{node['nginx']['log_dir']}/#{params[:name]}/access" do 
        owner "root"
        group "root"
        mode 00644
        recursive true
        action :create
    end
    directory "#{node['nginx']['log_dir']}/#{params[:name]}/error" do 
        owner "root"
        group "root"
        mode 00644
        action :create
    end
    if params[:custom_config] then
        vhost_include = "#{node['nginx']['dir']}/sites-available/#{params[:name]}_include.conf"
        cookbook_file vhost_include do
            source "#{node['osl-nginx']['hostname']}/#{params[:name]}.conf" 
            cookbook params[:cookbook] if params[:cookbook]
            owner "root"
            group "root"
            mode 0644
            if ::File.exists?("#{node['nginx']['dir']}/sites-enabled/#{params[:name]}.conf")
                notifies :reload, "service[nginx]"
            end
        end
    end
    template "#{node['nginx']['dir']}/sites-available/#{params[:name]}.conf" do
        source params[:template] || "nginx_app.conf.erb"
        cookbook params[:cookbook] if params[:cookbook]
        owner "root"
        group "root"
        mode 0644
        variables({ 
            :server_aliases => params[:server_aliases] || [],
            :params => params
        })
        if ::File.exists?("#{node['nginx']['dir']}/sites-enabled/#{params[:name]}.conf")
            notifies :reload, "service[nginx]"
        end
    end 
    site_enabled = params[:enable]
    nginx_site "#{params[:name]}.conf" do
        enable site_enabled
    end
end 
