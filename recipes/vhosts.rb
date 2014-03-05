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

#Set up log directories
node['osl-nginx']['hostsites']['enabled'].each do |ensite|
    directory "#{node['nginx']['log_dir']}/#{ensite}/access" do 
        owner "root"
        group "root"
        mode 00644
        recursive true
        action :create
    end
    directory "#{node['nginx']['log_dir']}/#{ensite}/error" do 
        owner "root"
        group "root"
        mode 00644
        action :create
    end
    template "#{node['nginx']['dir']}/sites-available/#{ensite}.conf" do
        source "#{node['osl-nginx']['hostname']}/#{ensite}.conf.erb"
        mode "0644"
        owner "root"
        group "root"
        notifies :reload, "service[nginx]"
    end
    nginx_site ensite do
        action :enable
    end
end

node['osl-nginx']['hostsites']['disabled'].each do |dissite| 
    nginx_site dissite do
        action :disable
    end
end
