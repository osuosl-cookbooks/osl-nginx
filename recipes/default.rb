#
# Cookbook:: osl-nginx
# Recipe:: default
#
# Copyright:: 2014-2023, Oregon State University
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

osl_firewall_port 'http'

nginx_install 'osuosl' do
  source 'repo'
end

nginx_config 'osuosl' do
  notifies :restart, 'nginx_service[osuosl]', :delayed
end

nginx_service 'osuosl' do
  action :enable
  delayed_action :start
end

directory "#{nginx_dir}/includes.d"
