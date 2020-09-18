#
# Cookbook:: osl-nginx
# Recipe:: default
#
# Copyright:: 2014-2020, Oregon State University
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
include_recipe 'firewall::http'

nginx_install 'repo'

# make this availible for notify statements
service 'nginx' do
  action :nothing
end

# LETS REMOVE CENTOS 6 AS SOON AS WE CAN *o* this is so weird *o*
if node['platform']['version'].to_i < 7
  package 'nginx' do
    notifies :restart, 'service[nginx]'
    action [:remove, :install]
  end
end
