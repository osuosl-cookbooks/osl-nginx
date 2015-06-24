#
# Cookbook Name:: osl-nginx
# Recipe:: project_etherpad-lite
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
nginx_app 'etherpad-lite.osuosl.org' do
  template 'etherpad/etherpad-lite.osuosl.org.erb'
end

nginx_app 'etherpad-lite.osuosl.org-back' do
  template 'etherpad/etherpad-lite.osuosl.org-back.erb'
  enable false
end

nginx_app 'nginx_status' do
  template 'etherpad/nginx_status.erb'
end
