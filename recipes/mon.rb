#
# Cookbook:: osl-nginx
# Recipe:: mon
#
# Copyright:: 2014-2021, Oregon State University
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
include_recipe 'osl-nrpe::check_http'

if node['platform_version'].to_i < 8
  include_recipe 'osl-munin::client'

  directory '/etc/munin/plugins' do
    recursive true
  end

  template ::File.join(node['munin']['basedir'], 'plugin-conf.d/nginx') do
    source 'munin/nginx.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

  munin_plugin 'nginx_request'
  munin_plugin 'nginx_status'
  munin_plugin 'nginx_memory'
end
