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

# Loop over enabled sites
if node['osl-nginx']['hostsites']['enabled'] then
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
        cookbook_file "#{node['nginx']['dir']}/sites-available/#{ensite}.conf" do
            source "#{node['osl-nginx']['hostname']}/#{ensite}.conf"
            mode "0644"
            owner "root"
            group "root"
            notifies :reload, "service[nginx]"
        end
        nginx_site "#{ensite}.conf" do
            action :enable
        end
    end
end

if node['osl-nginx']['hostsites']['disabled'] then
    node['osl-nginx']['hostsites']['disabled'].each do |dissite| 
        nginx_site "#{dissite}.conf" do
            action :disable
        end
    end
end 
