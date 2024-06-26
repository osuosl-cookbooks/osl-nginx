#
# Cookbook:: osl-nginx
# Recipe:: default
#
# Copyright:: 2014-2024, Oregon State University
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

Chef::DSL::Universal.include(Nginx::Cookbook::Helpers)

include_recipe 'osl-selinux'

selinux_module 'osl-nginx' do
  content <<~EOM
    module osl-nginx 1.0;

    require {
            type httpd_t;
            type var_run_t;
            class file { unlink open read write };
    }

    #============= httpd_t ==============
    allow httpd_t var_run_t:file { unlink open read write };
  EOM
end

osl_firewall_port 'http'

nginx_install 'osuosl' do
  source 'repo'
end

nginx_config 'osuosl' do
  notifies :restart, 'nginx_service[osuosl]', :delayed
end

cookbook_file '/etc/nginx/conf.d/osuosl.conf' do
  notifies :restart, 'nginx_service[osuosl]', :delayed
end

nginx_service 'osuosl' do
  action :enable
  delayed_action :start
end

dhparam = data_bag_item('nginx', 'dhparam')

file '/etc/nginx/dhparam.pem' do
  sensitive true
  mode '0640'
  content dhparam['key']
  notifies :reload, 'nginx_service[osuosl]', :delayed
end

directory "#{nginx_dir}/includes.d"

logrotate_package 'osl-nginx'

logrotate_app 'nginx' do
  path "#{nginx_log_dir}/*/*/*.log"
  frequency 'daily'
  postrotate "[ ! -f #{nginx_pid_file} ] || kill -USR1 `cat #{nginx_pid_file}`"
end
